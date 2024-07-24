class Api::V1::PostsController < ApplicationController
    # GET /posts
    def index
        posts = Post.joins(:user).select("posts.*, users.name AS name, users.id AS userId").order(created_at: "DESC")
        render json: posts
    end
    
    # GET /posts/1
    def show
        posts = Post.find(params[:id])
        render json: posts
    end

    # GET /posts/all
    def all
        posts = Post.joins(:user).select("posts.*, users.name AS name, users.id AS userId").order(created_at: "DESC")
        render json: posts
    end

    # GET /posts/following
    def following
        return unless authenticate_user
        follower_user_ids = @current_user.feed
        posts = Post.where(user_id: follower_user_ids).joins(:user).select("posts.*, users.name AS name, users.id AS userId").order(created_at: :desc)
        render json: posts
    end

    def create
        post = Post.new(post_params)

        if post.save
            render json: post, status: :created
        else
            render json: post.errors, status: :unprocessable_entity
        end
    end

    private
        def post_params
            params.require(:post).permit(:user_id, :content)
        end
end
