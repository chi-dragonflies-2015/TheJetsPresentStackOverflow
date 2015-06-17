helpers do

  def user_authenticated?
    session[:id] != nil
  end

  def user_authorized?(relevant_id)
    user = User.find_by(id: session[:id])
    user.id = relevant_id
  end

end