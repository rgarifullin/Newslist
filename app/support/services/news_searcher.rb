class Services::NewsSearcher
  def initialize(user, list, params)
    @user = user
    @list = list
    @params = params
  end

  def search
    unless @params[:text].nil? || @params[:text].empty?
      @list = @list.where('author LIKE ? OR text LIKE ?',
                          "%#{@params[:text]}%", "%#{@params[:text]}%")
    end

    if @params[:end_date].nil? || @params[:end_date].empty?
      @params[:end_date] = Date.today.tomorrow.strftime("%Y-%m-%d")
    end
    @params[:start_date] ||= ''
    @list = @list.where(created_at: @params[:start_date]..@params[:end_date])
puts @list.length, @params[:text]
    final = []
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
    final.empty? ? @list : final
  end
end
