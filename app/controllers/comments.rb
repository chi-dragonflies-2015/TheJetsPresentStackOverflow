require 'json'

post '/questions/:id/comments/new' do
  check_auth
  if question = Question.find(params[:id])
    comment = Comment.new(content: params[:content], commenter_id: session[:id].to_i)
    question.comments << comment
  end
  if request.xhr?
    id = comment.id
    content = comment.content
    type = "question"
    content_type :json
    JSON.generate(id: id, content: content, type: type)
  else
    redirect "/questions/#{question.id}"
  end
end

post '/answers/:id/comments/new' do
  check_auth
  if answer = Answer.find(params[:id])
    question = answer.question
    comment = Comment.new(content: params[:content], commenter_id: session[:id].to_i)
    answer.comments << comment
  end
  if request.xhr?
    id = comment.id
    content = comment.content
    type = "answer"
    content_type :json
    JSON.generate(id: id, content: content, type: type)
  else
    redirect "/questions/#{question.id}"
  end
end

put '/comments/:id/edit' do
  comment = Comment.find(params[:id])
  halt 401 if !user_authorized?(comment.commenter_id)
  comment.update_attributes(
  content: params[:content])
  params[:content]
end

delete '/comments/:id/delete' do
  comment = Comment.find(params[:id])
  halt 401 if !user_authorized?(comment.commenter_id)
  unless question_id = comment.commentable_id
    question_id = comment.commentable_id
  end
  comment.destroy

  if request.xhr?
    params[:id]
  else
    redirect "/questions/#{question_id}"
  end
end
