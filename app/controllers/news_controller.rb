class NewsController < ApplicationController
  def index
    @newslist = News.all
    if can? :add, News
      new_news = News.new
      can_add = true
    end

    search if params[:commit]

    read_statistics if can? :stats, News
    respond_to do |format|
      format.json { render json: { newslist: @newslist,
                                   total: @total,
                                   total_readed: @total_readed,
                                   today: @today,
                                   readed_today: @readed_today,
                                   read_status: @read_status,
                                   can_add: can_add } }
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
    @total = News.count
    @total_readed = Newsuser.where(user_id: current_user, read: true).count
    today_news = News.where(created_at: Date.current..Date.current + 1)
    @today = today_news.size
    @readed_today = Newsuser.where(
      read: true,
      updated_at: Date.today..Date.today.tomorrow,
      user_id: current_user
    ).count

    @read_status = []
    @newslist.each do |news|
      @read_status << current_user.read?(current_user, news) ? true : false
    end
  end

  def search
    unless params[:text].nil? || params[:text].empty?
      @newslist = @newslist.where('author LIKE ? OR text LIKE ?',
                                  "%#{params[:text]}%", "%#{params[:text]}%")
    end

    if params[:end_date].nil? || params[:end_date].empty?
      params[:end_date] = Date.today.tomorrow.strftime("%Y-%m-%d")
    end
    params[:start_date] ||= ''
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
