#Rounds Controller

post '/rounds' do
  new_round = Round.new(params[:round])
  if new_round.save
   new_round.create_shuffled_deck
   @round = new_round
   erb :'rounds/next_card'
  else
    redirect '/oops'
  end
end
