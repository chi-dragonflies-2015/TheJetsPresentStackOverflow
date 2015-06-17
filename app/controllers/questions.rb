
get '/questions' do
  erb :index
end

get '/questions/new' do
  check_auth
  erb :'/questions/new'
end

post '/questions' do
  check_auth
  question = Question.new(params[:new_question])
  if question.save
    current_user.questions << question
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
  check_auth
  @question = Question.find(params[:id])
  halt 401, "forbidden" if !user_authorized?(@question.asker.id)
  erb :'/questions/edit'
end

put '/questions/:id' do
  check_auth
  @question = Question.find(params[:id])
  halt 401, "forbidden" if !user_authorized?(@question.asker.id)
  if @question.update(params[:question])
    redirect "/questions/#{@question.id}"
  else
    erb :'/questions/edit'
  end
end

delete '/questions/:id' do
  check_auth
  @question = Question.find(params[:id])
  halt 401, "forbidden" if !user_authorized?(@question.asker.id)
  @question.destroy
  redirect '/'
end

#add user auth
get '/questions/:id/:vote_type' do
  @question = Question.find(params[:id])
  if params[:vote_type] == 'upvote'
    @question.votes.create(value: 1)
  else
    @question.votes.create(value: -1)
  end

  if request.xhr?
    id = question.id
    count = question.votes.count.to_s
    content_type :json
    JSON.generate(count: count, id: id)
  end
end







