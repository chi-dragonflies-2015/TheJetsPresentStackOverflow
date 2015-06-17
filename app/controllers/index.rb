# Before any request that isn't just "/", "/questions/:id", "/questions",  "/users/new" require authT

before %r{^(?!.*\/users\/new$|\/$|.*\/users\/login$|\/users\/sessions$|\/users\/logout$|\/questions\/\d+$|\/questions$|\/users$).*} do
  redirect '/users/login' if !user_authenticated?
end

get '/' do
  erb :index
end
