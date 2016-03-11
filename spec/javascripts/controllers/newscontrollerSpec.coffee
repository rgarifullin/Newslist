#= require spec_helper

describe 'NewsController', ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController = (results)->
    inject(($location, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      httpBackend = $httpBackend

      if results
        httpBackend.expectGET('/news?format=json').respond(results)

      ctrl = $controller('NewsController', $scope: scope, $location: location)
    )

  beforeEach module('newslist')

  results =
    newslist: [
      {
        news:
          id: 1
          author: 'Fox'
          text: 'Britain scientists developed new amazing technology.'
          created_at: new Date()
          updated_at: new Date()
        status:
          id: 1
          news_id: 1
          user_id: 1
          read: true
          created_at: new Date()
          updated_at: new Date()
      }
      {
        news:
          id: 2
          author: 'Smith'
          text: 'New film about agent 007 was released.'
          created_at: new Date()
          updated_at: new Date()
        status: false
      }
    ]
    can_add: false
    can_stats: true

  beforeEach ->
    setupController(results)
    httpBackend.flush()

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  it 'defaults to index page', ->
    expect(scope.data).toEqual(results.newslist)

  describe 'save()', ->
    news =
      id: 3
      author: 'Lebedev'
      text: 'Welcome to our incredible jasmine test!'
      created_at: new Date()
      updated_at: new Date()

    newResponse = null

    beforeEach ->
      setupController()

      httpBackend.expectGET('/news?format=json').respond(200, results)
      httpBackend.expectPOST('/news?format=json').respond(200, news)

      newResults = results
      newResults.newslist.push({news: news, status: false})
      newResponse = newResults.newslist

      httpBackend.expectGET('/news?format=json').respond(200, newResults)

    it 'update statistics after adding new news', ->
      scope.save()
      httpBackend.flush()

      expect(scope.data).toEqual(newResponse)
      expect(scope.stats.total).toBe(3)

  describe 'calcStatistics()', ->
    beforeEach ->
      setupController(results)
      scope.update()

      httpBackend.expectGET('/news?format=json').respond(200, results)

    it 'calculates right statistics after call of update()', ->
      httpBackend.flush()

      stats =
        total: results.newslist.length
        total_readed: 1
        today: results.newslist.length
        readed_today: 1

      expect(scope.stats).toEqual(stats)
