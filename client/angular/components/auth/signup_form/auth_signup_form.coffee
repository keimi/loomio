AppConfig   = require 'shared/services/app_config.coffee'
EventBus    = require 'shared/services/event_bus.coffee'
AuthService = require 'shared/services/auth_service.coffee'
I18n        = require 'shared/services/i18n.coffee'
request     = require 'request'
{ hardReload } = require 'shared/helpers/window.coffee'

{ submitOnEnter } = require 'shared/helpers/keyboard.coffee'

angular.module('loomioApp').directive 'authSignupForm', ->
  scope: {user: '='}
  templateUrl: 'generated/components/auth/signup_form/auth_signup_form.html'
  controller: ['$scope', ($scope) ->
    $scope.recaptchaKey = AppConfig.recaptchaKey
    $scope.name         = $scope.user.name
    $scope.vars         = {name: $scope.name}
    $scope.allow        = ->
      AppConfig.features.app.create_user or AppConfig.pendingIdentity

    $scope.submit = ->
      if $scope.vars.name and $scope.vars.rut and $scope.vars.code
        $scope.user.errors = {}
        EventBus.emit $scope, 'processing'
        $scope.user.name  = $scope.vars.name
        request.get {uri:'https://api.revoluciondemocratica.cl/verify?rut=' + $scope.vars.rut + '&number=' + $scope.vars.code, json : true},
          (err, r, body) ->
            if body.status == 'fail'
              $scope.user.isRd = false
              $scope.user.errors = name: ['verificación fallida']
              hardReload()
            else
              $scope.user.isRd = body.padron
              $scope.user.rut = body.rut

              AuthService.signUp($scope.user).finally -> EventBus.emit $scope, 'doneProcessing'
      else
        $scope.user.errors =
          name: [I18n.t('auth_form.name_required')]

    submitOnEnter($scope, anyEnter: true)
    EventBus.emit $scope, 'focus'
  ]
