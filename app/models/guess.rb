class Guess < ActiveRecord::Base

  belongs_to :round
  belongs_to :flashcard
  has_one :deck, through: :flashcard

  def check_guess(guessed_answer)
    #ZM: This is good to have a method that checks for this..
    #ZM: You should push the actual logic down to the flashcard though
    #ZM: and remeber if the logical statement returns true or false, you don't have to return it.

    #ZM: gussed_answer == self.flashcard.answer is all you need here
    guessed_answer == self.flashcard.answer
  end

  def right_guess
    self.flashcard.answer #?
  end

end
