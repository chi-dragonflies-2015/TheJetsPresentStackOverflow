helpers do

  def user_authenticated?
    session[:id] != nil
  end

  def user_authorized?(relevant_id)
    return false if !user_authenticated?
    current_user.id == relevant_id
  end

  def current_user
    User.find_by(id: session[:id]) if session[:id]
  end

  def pretty_date(date)
    month = date.month.to_s
    day = date.day.to_s
    year = date.year.to_s
    month + "/" + day + "/" + year
  end

end
