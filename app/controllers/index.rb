before %r{\S*((new)|(edit))\S*} do
  redirect '/login' if !user_authenticated?
end

get '/' do
  erb :index
end
