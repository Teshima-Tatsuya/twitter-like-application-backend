class Api::V1::PostsController < ApplicationController
    # GET /posts
    def index
        posts = Post.all
        render json: posts
    end
    
    # GET /posts/1
    def show
        posts = Post.find(params[:id])
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
