class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 254 }
    validates :password_digest, presence: true, length: { maximum: 128 }

    has_many :posts
    has_many :followings, foreign_key: :following_user_id, class_name: 'Follow'
    has_many :followers, foreign_key: :follower_user_id, class_name: 'Follow'
    has_many :followed_users, through: :followings, source: :follower_user
    has_many :following_users, through: :followers, source: :following_user

    def follow(user)
        followings.create(follower_user: user)
    end

    def unfollow(user)
        followings.find_by(follower_user: user)&.destroy
    end

    def following?(user)
        followings.exists?(follower_user: user)
    end

    def feed
        followed_users.pluck(:id)
    end
end