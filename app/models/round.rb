class Round < ActiveRecord::Base
  has_many :guesses
  belongs_to :deck
  has_many :flashcards, through: :guesses

  attr_accessor :shuffled_deck

  def initialize
    @shuffled_deck = self.deck.flashcards.to_a.shuffle
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
