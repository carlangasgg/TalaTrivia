class AddUidToQuestionOptions < ActiveRecord::Migration[7.1]
  def change
    add_column :question_options, :uid, :string
    add_index  :question_options, :uid, unique: true
  end
end
