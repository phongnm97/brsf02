class User < ApplicationRecord
  enum role: {user: 0, admin: 1}
  has_many :favorite_books, dependent: :destroy
  has_many :book_statuses, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name:  Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:  Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  before_save :downcase_email

  has_secure_password
  validates :password, presence: true,
  length: {minimum: Settings.users.password.min_length}, allow_nil: true
  before_save{email.downcase!}

  validates :name, presence: true,
  length: {maximum: Settings.users.name.max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true,
  length: {maximum: Settings.users.name.max_length},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  private

  def downcase_email
    email.downcase!
  end
end
