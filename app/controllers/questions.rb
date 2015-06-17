
get '/questions' do
  erb :index
end

#session id add user auth
get '/questions/new' do
  erb :'/questions/new'
end

post '/questions' do
  redirect '/login' if !user_authenticated?
  question = Question.new(params[:new_question])
  if question.save
    redirect "/questions/#{question.id}"
  else
    erb :'/questions/new'
  end
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  erb :'/questions/show'
end

get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  halt 401, "forbidden" if !user_authorized?(@question.id)
  erb :'/questions/edit'
end

put '/questions/:id' do
  @question = Question.find(params[:id])
  halt 401, "forbidden" if !user_authorized?(@question.id)
  if @question.update(params[:question])
    redirect "/questions/#{@question.id}"
  else
    erb :'/questions/edit'
  end
end

delete '/questions/:id' do
  @question = Question.find(params[:id])
  halt 401, "forbidden" if !user_authorized?(@question.id)
  @question.destroy
  redirect '/'
end
