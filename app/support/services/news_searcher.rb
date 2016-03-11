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

    condition_by_status(@params[:status])
  end

  private

  def condition_by_date(start_date, end_date)
    start_date = DateTime.new if start_date.nil? || start_date.empty?

    end_date = DateTime.now.tomorrow if end_date.nil? || end_date.empty?

    "created_at BETWEEN '#{start_date}' AND '#{end_date}'"
  end

  def condition_by_text(text)
    "author LIKE '%#{text}%' OR text LIKE '%#{text}%'"
  end

  def condition_by_status(status)
    @list ||= News.all
    return @list if status == 'all' || status.nil?

    final = []
    @list.each do |item|
      case status
      when 'readed'
        final << item if @user.read?(item)
      when 'unreaded'
        final << item unless @user.read?(item)
      else
        next
      end
    end
    final
  end
end
