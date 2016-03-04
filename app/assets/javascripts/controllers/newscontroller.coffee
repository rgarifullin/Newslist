controllers = angular.module('controllers')
controllers.controller('NewsController', [ '$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource) ->
    News = $resource('/news', { format: 'json' })
    News.get (results) ->
      $scope.posts = results.newslist
      $scope.total = results.total
      $scope.total_readed = results.total_readed
      $scope.today = results.today
      $scope.readed_today = results.readed_today
])
