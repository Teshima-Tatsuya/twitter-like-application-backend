class Api::V1::FollowsController < ApplicationController
    before_action :authenticate_user

    def create
        user_to_follow = User.find(params[:id])
        @current_user.follow(user_to_follow)
        render json: { success: true }
    end

    def destroy
        user_to_unfollow = User.find(params[:id])
        @current_user.unfollow(user_to_unfollow)
        render json: { success: true }
    end
end