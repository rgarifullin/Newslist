#= require spec_helper

describe 'Statistics', ->
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

  it 'calculates statistics', ->
    statsElement = React.createElement(Statistics, { data: newslist })
    stats = ReactTestUtils.renderIntoDocument(statsElement)

    expect(stats.refs.stats_aside.children[1].innerText).toBe("Total news: 2")
    expect(stats.refs.stats_aside.children[2].innerText).toBe("Readed news: 1")
    expect(stats.refs.stats_aside.children[3].innerText).toBe("Today's news: 2")
    expect(stats.refs.stats_aside.children[4].innerText).toBe("Today's readed news: 1")
