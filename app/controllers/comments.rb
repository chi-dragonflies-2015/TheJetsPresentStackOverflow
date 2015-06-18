require 'json'

post '/questions/:id/comments/new' do
  if question = Question.find(params[:id])
    comment = Comment.new(content: params[:content], commenter_id: session[:id].to_i)
    question.comments << comment
  end
  if request.xhr?
    id = comment.id
    content = comment.content
    content_type :json
    JSON.generate(id: id, content: content)
  else
    redirect "/questions/#{question.id}"
  end
end

post '/answers/:id/comments/new' do
  if answer = Answer.find(params[:id])
    comment = Comment.new(content: params[:content], commenter_id: session[:id].to_i)
    answer.comments << comment
  end
  if request.xhr?
    id = comment.id
    content = comment.content
    content_type :json
    JSON.generate(id: id, content: content)
  else
    redirect "/questions/#{question.id}"
  end
end

put '/comments/:id/edit' do
  Comment.find(params[:id]).update_attributes(
  content: params[:content])

  params[:content]
end

delete '/comments/:id/delete' do
  comment = Comment.find(params[:id])
  question_id = comment.commentable_id
  comment.destroy

  if request.xhr?
    params[:id]
  else
    redirect "/questions/#{question_id}"
  end
end