class UsersController < ApplicationController
    skip_before_action :authenticate_request
    def user_params
        params.required(:user).permit(:name, :description, :email, :password, :password_confirmation)
    end
    def signup
        User.create(user_params)
        render json: User.all
    end 
    def editusercred
        @user = User.find(params[:user_id])
        if @user.update(postparams)
            render json: @user, status: :ok
        else
            render json: user.errors, status: :unprocessable_entity
        end
    end
end
