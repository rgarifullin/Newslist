controllers = angular.module('controllers')
controllers.controller('ModalController', [ '$scope', '$uibModal',
  ($scope, $uibModal) ->
    $scope.open = ->
      modalForm = $uibModal.open(
        templateUrl: 'new.html'
        controller: 'ModalFormController'
      )
])
