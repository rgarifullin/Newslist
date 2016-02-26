class NewsController < ApplicationController
  def index
    @newslist = News.all
    @total = News.count
  end

  def new
    @news = News.new
  end

  def create
    news = News.new(news_params)
    if news.save
      flash[:success] = t('flash_messages.create.success', resource: @news)
      redirect_to news_path
    else
      flash[:error] = t('flash_messages.create.failure', resource: @news)
      @news = news
      render :new
    end
  end

  private

  def news_params()
    params.require(:news).permit(:author, :text)
  end
end
