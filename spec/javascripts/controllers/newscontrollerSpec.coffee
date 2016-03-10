#= require spec_helper

describe 'NewsController', ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController = (results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      httpBackend = $httpBackend

      if results
        httpBackend.expectGET('/news?format=json').respond(results)

      ctrl = $controller('NewsController', $scope: scope, $location: location)
    )

  beforeEach module('newslist')

  results =
    newslist: [
      {
        id: 1
        author: "Fox"
        text: "Britain scientists developed new amazing technology."
        created_at: "2016-03-09T07:10:29.303Z"
        updated_at: "2016-03-09T07:10:29.303Z"
      }
      {
        id: 2
        author: "Smith"
        text: "New film about agent 007 was released."
        created_at: "2016-03-09T07:10:29.360Z"
        updated_at: "2016-03-09T07:10:29.360Z"
      }
    ]
    read_status: [
      {
        id: 1
        news_id: 1
        user_id: 1
        read: true
        created_at: "2016-03-09T07:10:29.914Z"
        updated_at: "2016-03-09T07:55:47.825Z"
      }
      false
    ]
    can_add: true
    can_stats: true

  response = [
    {
      post:
        id: 1
        author: 'Fox'
        text: 'Britain scientists developed new amazing technology.'
        created_at: '2016-03-09T07:10:29.303Z'
        updated_at: '2016-03-09T07:10:29.303Z'
      status:
        id: 1
        news_id: 1
        user_id: 1
        read: true
        created_at: '2016-03-09T07:10:29.914Z'
        updated_at: '2016-03-09T07:55:47.825Z'
    }
    {
      post:
        id: 2
        author: 'Smith'
        text: 'New film about agent 007 was released.'
        created_at: '2016-03-09T07:10:29.360Z'
        updated_at: '2016-03-09T07:10:29.360Z'

      status: false
    }
  ]

  beforeEach ->
    setupController(results)
    httpBackend.flush()

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  it 'defaults to index page', ->
    expect(scope.data).toEqual(response)

  describe 'save()', ->
    news =
      id: 1
      author: 'Lebedev'
      text: 'Welcome to our incredible jasmine test!'
      created_at: '2016-03-10T14:17:06.116Z'
      updated_at: '2016-03-10T14:17:06.116Z'

    beforeEach ->
      setupController()
      httpBackend.expectGET('/news?format=json').respond(200)
      httpBackend.expectPOST('/news?format=json').respond(200, news)

    it 'redirects to index after adding new news', ->
      scope.save()
      httpBackend.flush()
      expect(location.path()).toBe('/')
