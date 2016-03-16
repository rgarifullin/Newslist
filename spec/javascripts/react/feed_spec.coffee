#= require spec_helper

describe 'Feed', ->
  ReactTestUtils = null
  beforeEach ->
    ReactTestUtils = React.addons.TestUtils

  newslist = [
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

  it 'shows message if no news are available', ->
    feedElement = React.createElement(Feed, { newslist: [] })
    feed = ReactTestUtils.renderIntoDocument(feedElement)

    expect(feed.refs.msg).toBeDefined()

  it 'shows news if data is available', ->
    feedElement = React.createElement(Feed, { newslist: newslist, can_stats: true })
    feed = ReactTestUtils.renderIntoDocument(feedElement)

    expect(feed.refs.msg).toBeUndefined()
