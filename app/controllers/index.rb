get '/' do
  @session_status = !!session[:id]
"INDEX"
erb :index
end
