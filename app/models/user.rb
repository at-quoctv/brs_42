class User < ApplicationRecord
  has_many :rates, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  before_save  :downcase_email
  has_secure_password
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, 
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def is_user? user
    self == user
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
