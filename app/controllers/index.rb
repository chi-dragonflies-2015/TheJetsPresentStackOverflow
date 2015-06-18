
def check_auth
  redirect '/users/login' if !user_authenticated?
end

get '/' do
  @questions = Question.all
  erb :index
end
