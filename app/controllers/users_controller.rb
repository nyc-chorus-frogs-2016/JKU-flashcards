get '/users/new' do
  erb :"/users/new"
end

post '/users' do
  #WE COULD ALSO DO THIS WITH AN ACTIVE RECORD VALIDATION: "confirmation".
  #That would be way better.
  #We can do that when we refactor.
  if params[:users]["password1"] == params[:users]["password2"]
    new_user = User.new(username: params[:users]["username"], email: params[:users]["email"], password: params[:users]["password1"])
    if new_user.save
      @success = true
      erb :"/login"
    else
      redirect "/oops"
    end
  else
    @error = "Your passwords don't match!"
    erb :"/oops"
  end
end

get "/users/:id" do
  @user = User.find_by(id: params[:id])
  erb :"users/show"
end
