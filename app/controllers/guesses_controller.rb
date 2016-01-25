#Guesses Controller

post '/guesses' do

  my_guess = Guess.find_or_create_by(params[:guess])

  correct_status = my_guess.check_guess(params[:answer]["answer"])

  if my_guess.attempt_count == nil
    counter = 1
  else
    counter = my_guess.attempt_count + 1
  end

  this_round = Round.find_by(id: my_guess.round_id)

  my_guess.update_attributes(correct: correct_status, attempt_count: counter)

  my_guess.flashcard.update_attributes(completed: correct_status)

  if this_round.game_over?
    #FOR NOW
    redirect "/rounds/#{this_round.id}/show"
  else
    redirect "/rounds/#{this_round.id}/next_card"
  end

end
