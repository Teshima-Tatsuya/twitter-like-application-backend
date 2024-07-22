class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true

    has_many :posts
    has_many :followings, foreign_key: :following_user_id, class_name: 'Follow'
    has_many :followers, foreign_key: :follower_user_id, class_name: 'Follow'

    def follow(user)
        followings.create(follower_user: user)
    end

    def unfollow(user)
        followings.find_by(follower_user: user)&.destroy
    end

    def following?(user)
        followings.exists?(follower_user: user)
    end
end