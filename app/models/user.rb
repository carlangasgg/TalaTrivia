class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_and_belongs_to_many :trivia

  ROLES = %w[admin player].freeze

  after_initialize do
    if self.new_record?
      self.role ||= 'player'
    end
  end

  def has_role?(role)
    self.role == role
  end
end
