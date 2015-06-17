require 'json'

post '/questions/:id/comments/new' do
  if question = Question.find(params[:id])
    comment = Comment.new(content: params[:content])
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