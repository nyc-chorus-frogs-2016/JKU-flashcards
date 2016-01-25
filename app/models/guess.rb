class Guess < ActiveRecord::Base

  belongs_to :round
  belongs_to :flashcard
  has_one :deck, through: :flashcard

  def check_guess(guessed_answer)
    if guessed_answer == self.flashcard.answer
      return true
    else
      return false
    end
  end

  def right_guess
    self.flashcard.answer #?
  end

end
