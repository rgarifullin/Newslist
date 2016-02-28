class NewsController < ApplicationController
  def index
    @newslist = News.all
    @total = News.count

    return unless current_user

    @total_readed = Newsuser.where(user_id: current_user, read: true).count
    today_news = News.where(created_at: Date.current..Date.current + 1)
    @today = today_news.size
    @readed_today = 0
    today_news.each do |news|
      @readed_today += 1 if news.newsusers.find_by(read: true,
                                                   user_id: current_user)
    end
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

  def news_params
    params.require(:news).permit(:author, :text)
  end
end
