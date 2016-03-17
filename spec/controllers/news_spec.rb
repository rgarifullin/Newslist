require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  describe 'GET #index' do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:user) { FactoryGirl.create(:user) }
    let!(:times_news) { FactoryGirl.create(:times_news) }
    let!(:rome_news) { FactoryGirl.create(:rome_news) }

    it 'responds successfully with an HTTP 200 status code' do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end

    it 'loads all of the news into @newslist' do
      get :index

      expected_newslist = [{ news: times_news, status: false }, { news: rome_news, status: false }]
      expect(assigns(:newslist)).to match_array(expected_newslist)
    end
  end
end
