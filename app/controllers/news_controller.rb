class NewsController < ApplicationController
  def index
    @newslist = News.all
    @new_news = News.new
    search if params[:commit]

    read_statistics if current_user
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
        format.js { render news }
      else
        flash[:error] = t('flash_messages.create.failure', resource: @news)
        @news = news
        render :new
      end
    end
  end

  def change_status
    newsuser = current_user.newsusers.find_by(news_id: params[:news_id])
    if newsuser.nil?
      newsuser = current_user.newsusers.create(news_id: params[:news_id], read: true)
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
    @total = News.count
    @total_readed = Newsuser.where(user_id: current_user, read: true).count
    today_news = News.where(created_at: Date.current..Date.current + 1)
    @today = today_news.size
    @readed_today = 0
    today_news.each do |news|
      @readed_today += 1 if news.newsusers.find_by(read: true,
                                                   user_id: current_user)
    end
  end

  def search
    unless params[:text].empty?
      @newslist = @newslist.where('author LIKE ? OR text LIKE ?',
                                  "%#{params[:text]}%", "%#{params[:text]}%")
    end

    if params[:end_date].empty?
      params[:end_date] = Date.today.tomorrow.strftime("%Y-%m-%d")
    end
    @newslist =
      @newslist.where(created_at: params[:start_date]..params[:end_date])

    final = []
    @newslist.each do |item|
      case params[:status]
      when 'readed'
        final << item if current_user.read?(current_user, item)
      when 'unreaded'
        final << item unless current_user.read?(current_user, item)
      else
        return
      end
    end
    @newslist = final if final
  end
end
