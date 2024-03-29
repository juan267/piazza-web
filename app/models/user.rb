class User < ApplicationRecord
  validates :name, presence: true
  validates :email, 
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false}
  validates :password, length: { minimum: 8 }
  validates :password, presence: :true

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :app_sessions

  has_secure_password

  normalizes :name, with: ->(name) {name.strip}
  normalizes :email, with: ->(email) {email.strip.downcase}

  def self.create_app_session(email:, password:)
    user = User.authenticate_by(email: email, password: password)
    user.app_sessions.create if user.present?
  end
end
