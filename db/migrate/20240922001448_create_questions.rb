class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :name,        null: false, default: ""
      t.text :description,   null: false, default: ""
      t.string :uid,         null: false
      t.integer :score,      null: false

      t.timestamps
    end
  end
end
