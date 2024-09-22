class CreateQuestionOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :question_options do |t|
      t.string :name, null: false, default: ""
      t.boolean :correct_option, default: false

      t.timestamps
    end
  end
end
