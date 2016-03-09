class NewsController < ApplicationController
  def index
    @newslist = News.all
    if can? :add, News
      new_news = News.new
      can_add = true
    end
    can_stats = can? :stats, News
    @newslist = Services::NewsSearcher.new(current_user, params).search if params[:commit]

    read_statistics if can? :stats, News
    respond_to do |format|
      format.json { render json: { newslist: @newslist,
                                   read_status: @read_status,
                                   can_add: can_add,
                                   can_stats: can_stats } }
      format.html {}
    end
  end

  def new
    redirect_to root_path unless can? :manage, News
    @new_news = News.new
  end

  def create
    news = News.new(news_params)
    respond_to do |format|
      if news.save
        flash[:success] = t('flash_messages.create.success', resource: @news)
        #redirect_to news_path
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

    redirect_to news_index_path
  end

  private

  def news_params
    params.require(:news).permit(:author, :text)
  end

  def read_statistics
    @read_status = []
    @newslist.each do |news|
      @read_status << if current_user.read?(news) then Newsuser.find_by(user_id: current_user, news_id: news) else false end
    end
  end
end
