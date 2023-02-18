class SignupController < ApplicationController
    skip_before_action :authenticate_request
    def signupuser
        render json: User.create(name: params[:name] ,email: params[:email], description: params[:description],  password: params[:password] , password_confirmation: params[:password_confirmation])
    end
end