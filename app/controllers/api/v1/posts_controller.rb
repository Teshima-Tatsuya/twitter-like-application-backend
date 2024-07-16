class Api::V1::PostsController < ApplicationController
    def show
        posts = Post.all
        render json: posts, status: :ok
    end
end
