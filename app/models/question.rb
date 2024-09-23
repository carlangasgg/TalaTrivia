class Question < ApplicationRecord
  before_create :generate_uid

  belongs_to :trivium
  has_many :question_options, dependent: :destroy

  validates :score, inclusion: { in: [1, 2, 3], message: "Field score must to be 1, 2, or 3" }

  private

  def generate_uid
    self.uid = loop do
      random_uid = SecureRandom.alphanumeric(12)
      break random_uid unless Question.exists?(uid: random_uid)
    end
  end
end
