controllers = angular.module('controllers')
controllers.controller('NewsController', [ '$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource) ->
    News = $resource('/news', { format: 'json' })
    News.query (results) ->
      $scope.posts = results
])
