class ArticlesController < ApplicationController
    skip_before_action :authenticate_request
    require 'jwt'
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

    def postparams
        params.required(:article).permit(:title, :user_id, :content, :description, :category_id)
    end

    def showall
        temp = Article.joins(:user, :category).select('articles.id, articles.title, articles.description, articles.content, articles.created_at, users.name, users.designation, categories.name')
        render json: temp
    end
    def showarticlesbyuser
        render json: User.find(params[:user_id]).articles
    end

    def postarticle
        temp = params[:user_id]
        if validate_jwt_user(headers, temp)
            author = params[:user_id]
            category = params[:name]
            temp_cat = Category.find_by(name: category)
            if(temp_cat.nil?)
                new_cat = Category.create(name: params[:category])
            end
            render json: Article.create(title: params[:title], description: params[:description], content: params[:content], user_id: author, category_id: temp_cat.id)
        else
            render json:{"user":"invalid user"}
        end
    end

    def editarticle
        @article = Article.find(params[:article_id])
        if @article.update(postparams)
          render json: @article, status: :ok
        else
          render json: @article.errors, status: :unprocessable_entity
        end
    end

    def deletearticle
        temp = params[:user_id]
        if validate_jwt_user(headers, temp)
            article = Article.find(params[:article_id])
            Article.delete(article)
        else
            render json: {"user": "invalid_user"}
        end
    end
end


# 