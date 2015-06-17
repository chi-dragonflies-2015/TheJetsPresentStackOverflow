before %r{\S*((new)|(edit))\S*} do
  redirect '/login' if !user_authenticated?
end



get '/' do
  @session_status = !!session[:id]
  erb :index
end
