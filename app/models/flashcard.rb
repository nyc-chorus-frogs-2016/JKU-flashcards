class Flashcard < ActiveRecord::Base
  validates :question, :answer, null: false

  belongs_to :deck
  has_many :guesses

end
