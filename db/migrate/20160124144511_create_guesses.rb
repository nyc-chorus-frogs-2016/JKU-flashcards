class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer  :correct
      t.integer  :round_id
      t.integer  :flashcard_id
      t.integer  :attempt_count

      t.timestamps(null:false)
    end
  end
end
