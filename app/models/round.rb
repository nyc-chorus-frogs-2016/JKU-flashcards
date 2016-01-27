class Round < ActiveRecord::Base
  has_many :guesses
  belongs_to :deck
  has_many :flashcards, through: :deck
  belongs_to :user

  def random_card

    #ans_ids = round.guesses.where(correct: 1).pluck(:flashcard_id)
    #round.flashcards.reject{|card| ans_ids.include?( card.id) }

    # self.deck.flashcards.select {|card| card.guesses.where("correct = ?", !true)}.sample
    self.flashcards.select {|card| card.completed != 1}.sample

  end

  def game_over?

   #THERE HAS GOT TO BE A BETTER WAY
   #ZM; There is an any? and all? enumerable method that will do this.
   if self.flashcards.select{|card| card.completed != 1} == []
      return true
   end

   false

  end

  def total_attempts
    return nil if !game_over?
    attempts_array = self.guesses.map { |guess| guess.attempt_count}
    attempts_array.reduce(:+)
  end

  def first_try
    return nil if !game_over?
    attempts_array = self.guesses.map { |guess| guess.attempt_count}
    first_try_guesses = attempts_array.select { |guess| guess == 1 }
    first_try_guesses.count
  end

  def number_cards
    self.flashcards.count
  end

  def date_played
    self.created_at.strftime('%B %e, %Y')
  end

end
