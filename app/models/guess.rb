class Guess < ActiveRecord::Base
  validates :correct, :attempt_count, presence: true

  belongs_to :round
  belongs_to :flashcard

  def check_guess(guessed_answer)
    if guessed_answer == self.flashcard.answer
      self.correct = true;
    end
  end

  def right_guess
    self.flashcard.answer #?
  end

end
