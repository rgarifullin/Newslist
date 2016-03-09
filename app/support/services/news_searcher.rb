class Services::NewsSearcher
  def initialize(user, params)
    @user = user
    @params = params
  end

  def search
    query = []
    unless @params[:start_date].nil? && @params[:end_date].nil?
      query << condition_by_date(@params[:start_date], @params[:end_date])
    end
    unless @params[:text].nil? || @params[:text].empty?
      query << condition_by_text(@params[:text])
    end

    @list = News.where(query.join(' AND'))

    condition_by_status(@params[:status]) if @params[:status]
  end

  private

  def condition_by_date(start_date, end_date)
    if end_date.nil? || end_date.empty?
      end_date = Date.today.tomorrow.strftime("%Y-%m-%d")
    else
      end_date = end_date.split('T').first
    end

    if start_date.nil? || start_date.empty?
      start_date = Date.new(1970, 1, 1)
    else
      start_date = start_date.split('T').first
    end

    "created_at BETWEEN '#{start_date}' AND '#{end_date}'"
  end

  def condition_by_text(text)
    "author LIKE '%#{@params[:text]}%' OR text LIKE '%#{@params[:text]}%'"
  end

  def condition_by_status(status)
    final = []
    @list ||= News.all
    @list.each do |item|
      case @params[:status]
      when 'readed'
        final << item if @user.read?(item)
      when 'unreaded'
        final << item unless @user.read?(item)
      else
        next
      end
    end
    @list = final if final
  end
end
