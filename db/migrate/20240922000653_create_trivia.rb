class CreateTrivia < ActiveRecord::Migration[7.1]
  def change
    create_table :trivia do |t|
      
      t.string :name,        null: false, default: ""
      t.text :description,   null: false, default: ""
      t.string :uid,         null: false

      t.timestamps
    end
  end
end
