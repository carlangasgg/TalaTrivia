class Trivium < ApplicationRecord
  before_create :generate_uid

  has_and_belongs_to_many :users
  has_many :questions, dependent: :destroy

  private

  def generate_uid
    self.uid = loop do
      random_uid = SecureRandom.alphanumeric(12)
      break random_uid unless Trivium.exists?(uid: random_uid)
    end
  end
end
