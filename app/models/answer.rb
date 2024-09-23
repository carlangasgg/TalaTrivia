class Answer < ApplicationRecord
  belongs_to :question_option
  belongs_to :user
end
