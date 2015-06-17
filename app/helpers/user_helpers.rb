helpers do

  def user_authenticated?
    session[:id] != nil
  end

  def user_authorized?(relevant_id)
    return false if !user_authenticated?
    current_user.id == relevant_id
  end

  def current_user
    User.find_by(id: session[:id])
  end

end