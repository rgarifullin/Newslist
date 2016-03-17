require 'rails_helper'

RSpec.describe News, type: :model do
  let(:times_news) { FactoryGirl.create(:times_news) }
  let(:rome_news) { FactoryGirl.create(:rome_news) }

  it 'orders by author' do
    expect(News.order(:author)).to eq([rome_news, times_news])
  end

  it 'dont save empty news' do
    empty_news = News.new()

    expect(empty_news.valid?).to eq false
  end
end
