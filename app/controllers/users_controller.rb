class UsersController < ApplicationController
    def user_params
        params.required(:user).permit(:name, :description, :email, :password, :password_confirmation)
    end
    def signup
        User.create(user_params)
        render json: User.all
    end 
end
