class AddReferencesNeeded < ActiveRecord::Migration[7.1]
  def change
    add_reference :questions, :trivium, foreign_key: true
    add_reference :answers, :user, foreign_key: true
    add_reference :answers, :question_option, foreign_key: true
    add_reference :question_options, :question, foreign_key: true
  end
end
