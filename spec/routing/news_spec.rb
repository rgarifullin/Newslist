require 'rails_helper'

RSpec.describe 'routing to news', :type => :routing do
  it 'routes / to news#index' do
    expect(get: '/').to route_to(
      controller: 'news',
      action: 'index'
    )
  end

  it 'routes /news/new to news#new' do
    expect(get: '/news/new').to route_to(
      controller: 'news',
      action: 'new'
    )
  end

  it 'routes /news/id/change_status to news#change_status' do
    expect(patch: '/news/1/change_status').to route_to(
      controller: 'news',
      action: 'change_status',
      id: '1'
    )
  end
end
