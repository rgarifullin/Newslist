class NewsController < ApplicationController
  def index
    @newslist = News.all
  end

  def create
    @news = News.new(news_params)

    @news.save
  end

  private

  def news_params()
    params.require(:news).permit(:author, :text)
  end
end
