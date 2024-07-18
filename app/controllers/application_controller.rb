class ApplicationController < ActionController::API
    def authenticate_user
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = jwt_decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  
    private
  
    def jwt_decode(token)
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new decoded
    end
end