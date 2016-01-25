#Rounds Controller

post '/rounds' do
  new_round = Round.new(params[:round])
  if new_round.save

    new_round.flashcards.each do |card|
      card.update_attributes(completed: false)
    end

   @round = new_round
   erb :'rounds/next_card'
  else
    redirect '/oops'
  end
end

get '/rounds/:id/next_card' do
  @round = Round.find_by(id: params['id'])
  # binding.pry
  erb :'rounds/next_card'
end

get '/rounds/:id/show' do
  @round = Round.find_by(id: params['id'])
  # binding.pry
  erb :'rounds/show'
end
