#= require spec_helper

describe 'List', ->
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

  it 'passes data to Feed component', ->
    listElement = React.createElement(List, { newslist: newslist, can_add: false, can_stats: false })
    list = ReactTestUtils.renderIntoDocument(listElement)

    expect(list.refs.stats).toBeUndefined()
    expect(list.refs.feed.refs.new).toBeUndefined()

    expect(list.refs.feed.props.newslist).toEqual(newslist)
    expect(list.refs.feed.props.can_add).toEqual(false)
    expect(list.refs.feed.props.can_stats).toEqual(false)

  it 'shows Statistics for authorized user', ->
    listElement = React.createElement(List, { newslist: newslist, can_add: false, can_stats: true })
    list = ReactTestUtils.renderIntoDocument(listElement)

    expect(list.refs.stats).toBeDefined()

  it 'shows NewNews for admin', ->
    listElement = React.createElement(List, { newslist: newslist, can_add: true, can_stats: true })
    list = ReactTestUtils.renderIntoDocument(listElement)

    expect(list.refs.feed.refs.new).toBeDefined()
