class Round < ActiveRecord::Base
  has_many :guesses
  belongs_to :deck
  has_many :flashcards, through: :deck
  belongs_to :user

  def random_card

    # self.deck.flashcards.select {|card| card.guesses.where("correct = ?", !true)}.sample
    self.flashcards.select {|card| card.completed != 1}.sample

  end

  def game_over?

   #THERE HAS GOT TO BE A BETTER WAY
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
