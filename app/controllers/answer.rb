post '/answers' do
  if request.xhr?
    @question = Question.find(params[:question_id])
    @answer = Answer.create(params[:answer])
    @question.answers << @answer
    erb :'/answers/show', locals: {answer: @answer}, layout: false
  else
    erb :'/questions/show'
  end
end

put '/answers/:id/edit' do
   @answer = Answer.find(params[:id])
   @answer.update(params[:answer])
   content_type :json
   params[:answer].to_json
end


delete '/answers/:id' do
  @answer = Answer.find(params[:id])
  @answer.destroy
end
