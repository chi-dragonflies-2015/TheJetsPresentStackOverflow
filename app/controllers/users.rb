get '/users/login' do

  erb :'/users/login'
end

post '/users/sessions' do

end

get '/users/new' do

  erb :'/users/new'
end

post '/users' do
  if User.create(params[:user])
    redirect '/'
  else
    erb :'/users/new'
  end
end
