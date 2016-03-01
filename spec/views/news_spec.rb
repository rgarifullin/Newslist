require 'rails_helper'

RSpec.describe 'news/index', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:times_news) { FactoryGirl.create(:times_news) }
  let(:rome_news) { FactoryGirl.create(:rome_news) }

  it 'renders _news partial for each news' do
    assign(:newslist, [times_news, rome_news])
    render

    expect(view).to render_template(partial: '_news', count: 2)
    expect(view).not_to render_template(partial: '_statistics')
  end

  it 'renders _statistics partial for authenticated user' do
    sign_in user
    assign(:newslist, [times_news, rome_news])
    render

    expect(view).to render_template(partial: '_statistics')
  end

  it 'renders link_to Add news for admin user' do
    sign_in admin
    assign(:newslist, [times_news, rome_news])
    render

    assert_select '.add-news', text: 'Add news'
  end

  it 'doesnt render link_to Add news for other users' do
    sign_in user
    assign(:newslist, [times_news, rome_news])
    render
    
    assert_select '.add-news', text: 'Add news', count: 0
  end
end
