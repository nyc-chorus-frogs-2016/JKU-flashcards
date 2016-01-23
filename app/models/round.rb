class Round < ActiveRecord::Base
  has_many :guesses
  belongs_to :deck
  has_many :flashcards, through: :guesses

  attr_accessor :shuffled_deck


  #Ideally this would happen on the creation of the AR object
  #But we spent 10 minutes on Google and couldn't figure it out
  #Soo.....
  def create_shuffled_deck
    @shuffled_deck = self.deck.flashcards.to_a.shuffle
  end

  def shuffle_remaining_cards
    @shuffled_deck.shuffle
  end

  def no_more_cards?
    @shuffled_deck.empty?
  end

  def game_over?
    users_guesses = self.guesses.map { |guess| !!guess.correct }
    if users_guesses.include?(false)
      return false
    else
      return true
    end
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
    self.deck.flashcards.to_a.count
  end

  def date_played
    self.created_at.strftime('%B %e, %Y')
  end

end
