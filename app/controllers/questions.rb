
get '/questions' do
  erb :index
end

#session id add user auth
get '/questions/new' do
  erb :'/questions/new'
end

#add user auth
post '/questions' do
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


#add user auth
get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  erb :'/questions/edit'
end

#add user auth
put '/questions/:id' do
  @question = Question.find(params[:id])
  if @question.update(params[:question])
    redirect "/questions/#{@question.id}"
  else
    erb :'/questions/edit'
  end
end

#add user auth
delete '/questions/:id' do
  @question = Question.find(params[:id])
  @question.destroy
  redirect '/'
end
