get '/users/login' do
  if session[:id]
    redirect '/'
  else
    erb :'/users/login'
  end
end

post '/users/sessions' do
  if User.authenticate(params[:email], params[:password])
    session[:id] = User.find_by(email: params[:email]).id
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
