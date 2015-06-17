get '/users/login' do
  if session[:id]
    redirect '/'
  else
    erb :'/users/login'
  end
end

post '/users/sessions' do
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:id] = user.id
    redirect '/'
  else
    redirect '/users/login'
  end
end

get '/users/new' do
  if session[:id]
    redirect '/'
  else
    erb :'/users/new'
  end
end

post '/users' do
  if User.create(params[:user])
    redirect '/'
  else
    erb :'/users/new'
  end
end


# This we want to make this a post
get '/users/logout' do
  session[:id] = nil
  redirect '/'
end
