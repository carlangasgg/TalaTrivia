class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  before_create :generate_uid
  
  has_and_belongs_to_many :trivia

  scope :players, -> { where(role: 'player') }

  ROLES = %w[admin player].freeze

  after_initialize do
    if self.new_record?
      self.role ||= 'player'
    end
  end

  def has_role?(role)
    self.role == role
  end

  private

  def generate_uid
    self.uid = loop do
      random_uid = SecureRandom.alphanumeric(12)
      break random_uid unless Trivium.exists?(uid: random_uid)
    end
  end
end