class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :answers, dependent: :destroy

  before_create :generate_uid

  private

  def generate_uid
    self.uid = loop do
      random_uid = SecureRandom.alphanumeric(12)
      break random_uid unless Question.exists?(uid: random_uid)
    end
  end
end
