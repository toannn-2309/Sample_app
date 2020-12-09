class User < ApplicationRecord
  USERS_PARAMS = %i(name email password password_confirmation).freeze
  VALID_EMAIL_REGEX = Settings.user.email.regex

  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, :email, presence: true
  validates :name, length: {maximum: Settings.user.name.length}
  validates :email, length: {maximum: Settings.user.email.length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: true}
  validates :password, presence: true,
                      length: {minimum: Settings.user.password.length},
                      allow_nil: true

  before_save :downcase_email
  # before_create :create_activation_digest

  has_secure_password

  scope :activated, ->{where activated: true}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def activate
    update activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    self.activation_token = User.new_token
    update_attribute :activation_digest, User.digest(activation_token)
    # self.activation_digest = User.digest activation_token
    UserMailer.account_activation(self).deliver_now
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.time_expired.minutes.ago
  end

  def feed
    Micropost.order_post.user_feed following_ids << id
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
