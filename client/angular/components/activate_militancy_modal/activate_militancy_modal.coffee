AbilityService = require 'shared/services/ability_service.coffee'
ModalService   = require 'shared/services/modal_service.coffee'

angular.module('loomioApp').factory 'ActivateMilitancyModal', ->
  templateUrl: 'generated/components/activate_militancy_modal/activate_militancy_modal.html'
  controller: ['$scope', ($scope) ->

    $scope.submit = ->
      if AbilityService.canDeactivateUser()
        ModalService.open 'ActivateMilitancyForm'
      else
        ModalService.open 'OnlyCoordinatorModal'
  ]
