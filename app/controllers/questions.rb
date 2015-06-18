
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
get '/questions/:id/upvote' do
  @question = Question.find(params[:id])
  @question.votes.create(value: 1)
  if request.xhr?
    id = @question.id
    tally = @question.vote_tally
    content_type :json
    JSON.generate(id: id, tally: tally)
  else
    redirect '/questions/#{@question.id}'
  end
end

#add user auth
get '/questions/:id/downvote' do
  @question = Question.find(params[:id])
  @question.votes.create(value: -1)
  if request.xhr?
    id = @question.id
    tally = @question.vote_tally
    content_type :json
    JSON.generate(id: id, tally: tally)
  else
    redirect '/questions/#{@question.id}'
  end
end







