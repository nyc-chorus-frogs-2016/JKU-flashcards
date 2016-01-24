#Sessions Controller

post '/sessions' do
  user = User.find_by(username:params[:username] )
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/decks/index'
  else
    @error = "Incorrect username or password"
    erb :'/oops'
  end
end

get '/oops' do
  erb :"/oops"
end

delete '/sessions/logout' do
  session.clear()
  redirect '/'
end
