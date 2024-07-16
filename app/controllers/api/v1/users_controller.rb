class Api::V1::UsersController < ApplicationController
    # GET /users
    def index
        users = User.all
        render json: users
    end
    
    # GET /users/1
    def show
        users = User.find(params[:id])
        render json: users
    end

    def create
        user = User.new(user_params)

        if user.save
            render json: user, status: :created, location: user
        else
            render json: user.errors, status: :unprocessable_entity
        end
    end

    private
        def user_params
            params.require(:user).permit(:content)
        end
end
