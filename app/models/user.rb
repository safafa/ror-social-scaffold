class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :sent_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  # Users who have yet to confirme friend requests
  has_many :pending_friends, through: :sent_friendships, source: :user

  has_many :received_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  # Users who have requested to be friends
  has_many :friend_requests, through: :received_friendships, source: :friend

  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  # Users who have accepted to be friends
  has_many :friends, through: :confirmed_friendships

  def confirm_friend(user)
    friendship = sent_friendships.find { |friendship| friendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def request_friend?(user)
    friend_requests.include?(user)
  end

  def reject_friend(user)
    friendship = sent_friendships.find { |friendship| friendship.user == user }
    friendship.destroy
  end
end
