require 'digest'

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
            token = jwt_encode(user_id: user.id)
            render json: { user: user, token: token}, status: :created
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def profile
        authenticate_user
        render json: { user: @current_user}
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
        def jwt_encode(payload, exp = 24.hours.from_now)
            payload[:exp] = exp.to_i
            JWT.encode(payload, Rails.application.secrets.secret_key_base)
        end
        
end
