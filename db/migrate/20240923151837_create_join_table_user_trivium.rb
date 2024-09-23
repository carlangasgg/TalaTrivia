class CreateJoinTableUserTrivium < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :trivia do |t|
      t.index [:user_id, :trivium_id], unique: true
    end
  end
end
