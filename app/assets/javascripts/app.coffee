app = angular.module('newslist', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
])

app.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'NewsController'
      )
])

controllers = angular.module('controllers', [])
