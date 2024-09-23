class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :answers, dependent: :destroy
end
