#= require spec_helper

describe 'News', ->
  ReactTestUtils = null
  beforeEach ->
    ReactTestUtils = React.addons.TestUtils

  post =
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

  it 'shows news data', ->
    newsElement = React.createElement(News, { post: post, can_stats: true })
    news = ReactTestUtils.renderIntoDocument(newsElement)

    expect(news.refs.read).toBeDefined()
    expect(news.refs.read.innerText).toBe("Unread")
    expect(news.refs.author.innerText).toBe("Fox - ")
    expect(news.refs.text.innerText).toBe("Britain scientists developed new amazing technology.")
