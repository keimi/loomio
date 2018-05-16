Session = require 'shared/services/session.coffee'
Records = require 'shared/services/records.coffee'

{ submitForm } = require 'shared/helpers/form.coffee'
{ hardReload } = require 'shared/helpers/window.coffee'

angular.module('loomioApp').factory 'ActivateMilitancyForm', ->
  templateUrl: 'generated/components/deactivate_user_form/activate_militancy_form.html'
  controller: ['$scope', ($scope) ->
    $scope.user = Session.user().clone()

    $scope.submit = submitForm $scope, $scope.user,
      submitFn: Records.users.deactivate
      successCallback: -> hardReload()
  ]
