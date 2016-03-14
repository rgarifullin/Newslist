class NewsController < ApplicationController
  def index
    @newslist = News.all
    if params[:commit]
      @newslist = Services::NewsSearcher.new(current_user, params).search
    end

    prepare_data
    respond_to do |format|
      format.json { render json: { newslist: @newslist,
                                   can_add: (can? :add, News),
                                   can_stats: (can? :stats, News) } }
      format.html {}
    end
  end

  def new
    redirect_to root_path unless can? :manage, News
    @new_news = News.new
  end

  def create
    redirect_to root_path unless can? :manage, News
    news = News.new(news_params)
    respond_to do |format|
      if news.save
        flash[:success] = t('flash_messages.create.success', resource: @news)
        format.json { render json: news }
        format.html {}
      else
        flash[:error] = t('flash_messages.create.failure', resource: @news)
        @news = news
        render :new
      end
    end
  end

  def change_status
    newsuser = current_user.newsusers.find_by(news_id: params[:id])
    if newsuser.nil?
      newsuser = current_user.newsusers.create(news_id: params[:id], read: true)
      newsuser.save
    else
      newsuser.read ^= true
      newsuser.save
    end
    respond_to do |format|
      format.json { render json: { status: newsuser.read } }
    end
  end

  private

  def news_params
    params.require(:news).permit(:author, :text)
  end

  def prepare_data
    @newslist = @newslist.map do |news|
      {
        news: news,
        status:
          if (can? :stats, News) && current_user.read?(news)
            Newsuser.find_by(user_id: current_user, news_id: news)
          else
            false
          end
      }
    end
  end
end
