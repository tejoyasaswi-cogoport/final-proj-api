class UsersController < ApplicationController
    skip_before_action :authenticate_request
    def validate_jwt_user(headers, user_id)
        # Get the JWT token from the 'Authorization' header
        jwt_token = request.headers['Authorization']&.split(' ')&.last
        puts "reached"
        puts jwt_token
        # The secret key used to sign the JWT token
        begin
            # Decode the JWT token and verify the signature
            decoded_token = JWT.decode(jwt_token, Rails.application.secrets.secret_key_base)[0]
            duplicate_user_id = decoded_token['user_id']
            # Check if the user_id field in the payload matches the user ID parameter
            if duplicate_user_id.to_s == user_id.to_s
                return true
            else
                return false
            end
            rescue JWT::VerificationError, JWT::DecodeError
            # Handle errors caused by invalid tokens
            return false
        end
    end
    def user_params
        params.required(:user).permit(:name, :designation, :email, :password, :password_confirmation)
    end
    # def signup
    #     User.create(user_params)
    #     render json: User.all
    # end 
    def signupuser
        @user = User.new(user_params)
        @user.password = params[:password]
        if @user.save
            render json: @user
        else
            render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end
    def editusercred
        @user = User.find(params[:user_id])
        if(validate_jwt_user(headers, @user))
            if @user.update(user_params)
                render json: @user, status: :ok
            else
                render status: :unprocessable_entity
            end
        else
            render json:{"user":"invalid_user", "status":"unprocessable_entity"}
        end
    end
end
