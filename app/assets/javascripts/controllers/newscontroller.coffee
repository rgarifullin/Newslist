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
      $scope.can_add = results.can_add

    NewNews = $resource('/news', { format: 'json' }, { 'create': { method: 'POST' } })

    $scope.save = ->
      onError = ->
        alert("Can't create new news")
      NewNews.create($scope.news, ( ->
        $location.path('/')),
        onError
      )

    $scope.newNews = ->
      $location.path('/news/new')

    $scope.$on('event:add', (ev, args) ->
      $scope.news = args
      $scope.save()
      News.get (results) ->
        $scope.posts = results.newslist
        $scope.total = results.total
        $scope.total_readed = results.total_readed
        $scope.today = results.today
        $scope.readed_today = results.readed_today
        $scope.can_add = results.can_add
    )

    $scope.search = (start_date, end_date, status, text) ->
      News.get({ start_date: start_date, end_date: end_date, status: status, text: text, commit: 'Search'}, (results) ->
        $scope.posts = results.newslist
      )
])
