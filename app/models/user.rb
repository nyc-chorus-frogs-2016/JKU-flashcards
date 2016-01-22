class User < ActiveRecord::Base
  validates :username, :email, :password_hash, presence: true
  validates :username, uniqueness: true

  has_many :rounds
  has_many :guesses, through: :rounds
  has_many :decks, through: :rounds

include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
