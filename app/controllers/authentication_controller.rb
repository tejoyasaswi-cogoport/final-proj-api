class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request
   
    def login
      command = AuthenticateUser.call(params[:email], params[:password])
   
      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end

    # def logout
    #   token = request.headers['Authorization']&.split(' ')&.last
    #   if token.present?
    #     user_id = JsonWebToken.decode(token)[:user_id]
    #   end
    #   head :no_content
    # end

    def current_user
      token = request.headers['Authorization']&.split(' ')&.last
      value = 0
      if token.present?
        user_id = JsonWebToken.decode(token)[:user_id]
        @current_user ||= User.find_by(id: user_id)
        value = user_id
      end
      return value
    end

    def logout
      if (current_user.to_i == params[:user_id].to_i)
        session.delete(:user_id)
        render json: { message: "Successfully logged out" }, status: :ok
      else
        render json: { message: "User not logged in" }, status: :unauthorized
      end
    end
end