class SignupController < ApplicationController
    skip_before_action :authenticate_request
    def user_params
        params.required(:user).permit(:name, :designation, :email, :password, :password_confirmation)
    end
    def signupuser
        @user = User.new(user_params)
        if @user.save
            render json: @user
        else
            render json: {"status":"unprocessable_entity"}
        end
    end
end



# render json: User.create(name: params[:name] ,email: params[:email], designation: params[:designation],  password: params[:password] , password_confirmation: params[:password_confirmation])


# @user = User.new(user_params)
# if @user.save
#     render json: @user
# else
#     render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
# render json: User.create(name: params[:name] ,email: params[:email], designation: params[:designation],  password: params[:password] , password_confirmation: params[:password_confirmation])

# end