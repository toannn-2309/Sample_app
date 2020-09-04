class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email.regex

  validates :name, :email, :password, presence: true
  validates :name, length: {maximum: Settings.user.name.length}
  validates :email, length: {maximum: Settings.user.email.length},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, length: {minimum: Settings.user.password.length}

  before_save :downcase_email
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
