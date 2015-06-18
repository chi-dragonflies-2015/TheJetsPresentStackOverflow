post '/answers' do
  check_auth
  if request.xhr?
    @question = Question.find(params[:question_id])
    @answer = Answer.create(params[:answer])
    @question.answers << @answer
    erb :'/answers/show', locals: {answer: @answer}, layout: false
  end
end

put '/answers/:id/edit' do
  @answer = Answer.find(params[:id])
  halt 401 if !user_authorized?(@answer.answerer.id)
  @answer.update(params[:answer])
  content_type :json
  params[:answer].to_json
end


delete '/answers/:id' do
  @answer = Answer.find(params[:id])
  halt 401 if !user_authorized?(@answer.answerer.id)
  @answer.destroy
end

get '/answers/:id/upvote' do
  check_auth
  @answer = Answer.find(params[:id])
  @answer.votes.create(value: 1)
  if request.xhr?
    id = @answer.id
    tally = @answer.vote_tally
    content_type :json
    JSON.generate(id: id, tally: tally)
  end
end

get '/answers/:id/downvote' do
  check_auth
  @answer = Answer.find(params[:id])
  @answer.votes.create(value: -1)
  if request.xhr?
    id = @answer.id
    tally = @answer.vote_tally
    content_type :json
    JSON.generate(id: id, tally: tally)
  end
end
