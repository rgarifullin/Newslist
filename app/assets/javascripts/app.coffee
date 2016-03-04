app = angular.module('newslist', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'ui.bootstrap'
])

app.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: 'index.html'
        controller: 'NewsController'
      )
      .when('/news/new',
        templateUrl: 'new.html'
        controller: 'NewsController'
      )
])

controllers = angular.module('controllers', [])
