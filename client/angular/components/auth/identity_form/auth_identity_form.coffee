AppConfig   = require 'shared/services/app_config.coffee'
EventBus    = require 'shared/services/event_bus.coffee'
AuthService = require 'shared/services/auth_service.coffee'
I18n        = require 'shared/services/i18n.coffee'
request     = require 'request'
Records     = require 'shared/services/records.coffee'
Session     = require 'shared/services/session.coffee'

{ hardReload }    = require 'shared/helpers/window.coffee'
{ submitOnEnter } = require 'shared/helpers/keyboard.coffee'

angular.module('loomioApp').directive 'authIdentityForm', ->
  scope: {user: '=', identity: '='}
  templateUrl: 'generated/components/auth/identity_form/auth_identity_form.html'
  controller: ['$scope', ($scope) ->
    $scope.siteName = AppConfig.theme.site_name
    $scope.createAccount = ->
      EventBus.emit $scope, 'processing'
      console.log('user:')
      console.log($scope.user)

      console.log('rut and code')
      console.log($scope.vars.rut)
      console.log($scope.vars.code)

      if $scope.vars.rut and $scope.vars.code and $scope.vars.accept
        request.get {uri:'https://api.revoluciondemocratica.cl/verify?rut=' + $scope.vars.rut + '&number=' + $scope.vars.code + '&padron=servel', json : true},
          (err, r, body) ->
            if body.status == 'fail'
              $scope.user.isRd = false
              $scope.user.errors = rut: ['verificación fallida']
              hardReload()
            else
              AuthService.confirmOauth().then ->
                $scope.user = Session.user().clone()
                $scope.user.isRd = body.padron
                $scope.user.rut = body.rut
                Records.users.updateProfile($scope.user).then ->
                  hardReload()
              , ->
                EventBus.emit $scope, 'doneProcessing'
      else
        $scope.user.errors =
          rut: [I18n.t('auth_form.name_required')]

    $scope.submit = ->
      EventBus.emit $scope, 'processing'
      $scope.user.email = $scope.email
      AuthService.sendLoginLink($scope.user).then (->), ->
        $scope.user.errors = {email: [I18n.t('auth_form.email_not_found')]}
      .finally ->
        EventBus.emit $scope, 'doneProcessing'

    submitOnEnter $scope, anyEnter: true
  ]
