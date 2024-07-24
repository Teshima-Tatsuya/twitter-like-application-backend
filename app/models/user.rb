class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 254 }
    validates :password_digest, presence: true, length: { maximum: 128 }

    has_many :posts

    # フォローしている
    has_many :following_relations, foreign_key: :following_user_id, class_name: 'Follow'
    has_many :following_users, through: :following_relations, source: :follower_user

    # フォローされている
    has_many :follower_relations, foreign_key: :follower_user_id, class_name: 'Follow'
    has_many :follower_users, through: :follower_relations, source: :following_user

    def follow(user)
        following_relations.create(follower_user: user)
    end

    def unfollow(user)
        following_relations.find_by(follower_user: user)&.destroy
    end

    def following?(user)
        following_relations.exists?(follower_user: user)
    end

    def feed
        following_users.pluck(:id)
    end
end