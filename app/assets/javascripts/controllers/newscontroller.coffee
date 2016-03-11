controllers = angular.module('controllers')
controllers.controller('NewsController', [ '$scope', '$location', '$resource',
  ($scope, $location, $resource) ->
    MS_PER_DAY = 86400000

    News = $resource('/news', { format: 'json' })

    calcStatistics = ->
      $scope.total = $scope.data.length
      $scope.total_readed = (true for item in $scope.data when item.status.read).length
      today_beginning = new Date()
      today_beginning.setHours(0, 0, 0, 0)
      $scope.today = 0
      for item in $scope.data
        if Date.parse(item.news.created_at) > Date.parse(today_beginning) && Date.parse(item.news.created_at) < Date.parse(today_beginning) + MS_PER_DAY
          $scope.today += 1
      $scope.readed_today = 0
      for item in $scope.data
        if Date.parse(item.status.updated_at) > Date.parse(today_beginning) && Date.parse(item.status.updated_at) < Date.parse(today_beginning) + MS_PER_DAY
          $scope.readed_today += 1

    $scope.update = ->
      News.get (results) ->
        $scope.data = results.newslist
        $scope.can_add = results.can_add
        $scope.can_stats = results.can_stats
        calcStatistics()

    $scope.update()

    NewNews = $resource('/news', { format: 'json' }, { 'create': { method: 'POST' } })

    $scope.save = ->
      onError = ->
        alert("Can't create new news")
      NewNews.create($scope.news, ( ->
        $scope.update()),
        onError
      )

    $scope.newNews = ->
      $location.path('/news/new')

    $scope.$on('event:add', (ev, args) ->
      $scope.news = args
      $scope.save()
    )

    $scope.search = (start_date, end_date, status, text) ->
      News.get({ start_date: start_date, end_date: end_date, status: status, text: text, commit: 'Search'}, (results) ->
        $scope.data = results.newslist
      )

    ChangeStatus = $resource('/news/:id/change_status', { id: '@id', format: 'json' }, { 'update': { method: 'PATCH' } })
    $scope.change_status = (news_id) ->
      ChangeStatus.update({ id: news_id }, ->
      )
      $scope.update()
])
