controllers = angular.module('controllers')
controllers.controller('ModalFormController', [ '$scope', '$uibModalInstance',
  ($scope, $uibModalInstance) ->
    $scope.save = ->
      $scope.$parent.$broadcast('event:add', { author: $scope.news.author, text: $scope.news.text })
      $uibModalInstance.close()
])
