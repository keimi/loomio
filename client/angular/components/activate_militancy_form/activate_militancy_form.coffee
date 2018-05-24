AbilityService = require 'shared/services/ability_service.coffee'
ModalService   = require 'shared/services/modal_service.coffee'

Session = require 'shared/services/session.coffee'
Records = require 'shared/services/records.coffee'

{ submitForm } = require 'shared/helpers/form.coffee'

angular.module('loomioApp').factory 'ActivateMilitancyForm', ->
  templateUrl: 'generated/components/activate_militancy_form/activate_militancy_form.html'
  controller: ['$scope', ($scope) ->
    $scope.user = Session.user().clone()

    actionName = 'militancy_changed'

    $scope.submit = submitForm $scope, $scope.user,
      submitFn: Records.users.updateMilitancy
      flashSuccess: "activate_militancy_form.#{actionName}"
  ]