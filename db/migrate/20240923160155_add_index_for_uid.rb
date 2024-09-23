class AddIndexForUid < ActiveRecord::Migration[7.1]
  def change
    add_index :trivia, :uid,                unique: true
    add_index :questions, :uid,             unique: true
  end
end
