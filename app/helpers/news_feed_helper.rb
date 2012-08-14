module NewsFeedHelper
  def pretty_date(date)
    if date.nil?
      'Not Specified'
    elsif Date.today == date
      'Today'
    elsif Date.yesterday == date
      'Yesterday'
    else
      date.to_time.strftime('%m/%d/%y')
    end
  end
end
