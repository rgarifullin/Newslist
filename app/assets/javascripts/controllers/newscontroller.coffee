controllers = angular.module('controllers')
controllers.controller('NewsController', [ '$scope', '$location', '$resource',
  ($scope, $location, $resource) ->
    MS_PER_DAY = 86400000

    News = $resource('/news', { format: 'json' })

    News.get (results) ->
      $scope.data = results.newslist.map (item, i) ->
        { post: item, status: if results.read_status then results.read_status[i] else null }

      $scope.total = results.newslist.length
      $scope.total_readed = (item for item in results.read_status when item).length
      today_beginning = new Date()
      today_beginning.setHours(0, 0, 0, 0)
      $scope.today = 0
      for item in $scope.data
        if Date.parse(item.post.created_at) > Date.parse(today_beginning) && Date.parse(item.post.created_at) < Date.parse(today_beginning) + MS_PER_DAY
          $scope.today += 1
      $scope.readed_today = 0
      for item in results.read_status
        if Date.parse(item.updated_at) > Date.parse(today_beginning) && Date.parse(item.updated_at) < Date.parse(today_beginning) + MS_PER_DAY
          $scope.readed_today += 1
      $scope.can_add = results.can_add
      $scope.can_stats = results.can_stats

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
        $scope.data = results.newslist.map (item, i) ->
          { post: item, status: if results.read_status then results.read_status[i] else null }
        $scope.total = results.newslist.length
        today_beginning = new Date()
        today_beginning.setHours(0, 0, 0, 0)
        $scope.today = 0
        for item in $scope.data
          if Date.parse(item.post.created_at) > Date.parse(today_beginning) && Date.parse(item.post.created_at) < Date.parse(today_beginning) + MS_PER_DAY
            $scope.today += 1
    )

    $scope.search = (start_date, end_date, status, text) ->
      News.get({ start_date: start_date, end_date: end_date, status: status, text: text, commit: 'Search'}, (results) ->
        $scope.data = results.newslist.map (item, i) ->
          { post: item, status: if results.read_status then results.read_status[i] else null }
      )

    ChangeStatus = $resource('/news/:id/change_status', { id: '@id' }, { 'update': { method: 'PATCH' } })
    $scope.change_status = (news_id) ->
      ChangeStatus.update({ id: news_id }, ->
      )
      News.get (results) ->
        $scope.data = results.newslist.map (item, i) ->
          { post: item, status: if results.read_status then results.read_status[i] else null }
        $scope.total_readed = (item for item in results.read_status when item).length
        today_beginning = new Date()
        today_beginning.setHours(0, 0, 0, 0)
        $scope.readed_today = 0
        for item in results.read_status
          if Date.parse(item.updated_at) > Date.parse(today_beginning) && Date.parse(item.updated_at) < Date.parse(today_beginning) + MS_PER_DAY
            $scope.readed_today += 1
])
