class Deck < ActiveRecord::Base
  validates :name, presence: true

  has_many :rounds
  has_many :flashcards
  has_many :users, through: :rounds
  has_many :guesses, through: :flashcards

  belongs_to :creator, class_name: "User"
end
