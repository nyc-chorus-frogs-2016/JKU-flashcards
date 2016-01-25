class AddCompleteToFlashcards < ActiveRecord::Migration
  def change
    add_column :flashcards, :completed, :integer
  end
end
