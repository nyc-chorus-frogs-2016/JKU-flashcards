#Guesses Controller

#ZM: This logic just looks a little complex. I feel like that we can reduce it with some
# modifications to your schema and general logic.
post '/guesses' do

  my_guess = Guess.find_or_create_by(params[:guess])

  #ZM: Cool, instead of check_guess how about.. is_correct?() 
  correct_status = my_guess.check_guess(params[:answer]["answer"])

  counter = my_guess.attempt_count ? my_guess.attempt_count + 1 : 1


  this_round = Round.find_by(id: my_guess.round_id)
  my_guess.update_attributes(correct: correct_status, attempt_count: counter)
  my_guess.flashcard.update_attributes(completed: correct_status)

  #ZM: Good job making this a model method.  
  route = this_round.game_over? ? "show" : "next_card"
  redirect "/rounds/#{this_round.id}/#{route}"
end
