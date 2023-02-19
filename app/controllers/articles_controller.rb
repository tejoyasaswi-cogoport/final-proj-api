class ArticlesController < ApplicationController
    skip_before_action :authenticate_request
    def showall
        temp = Article.joins(:user, :category).select('articles.id, articles.title, articles.description, articles.content, articles.created_at, users.name, users.designation, categories.name')
        render json: temp
    end
    def showarticlesbyuser
        render json: User.find(params[:user_id]).articles
    end

    def postparams
        params.required(:article).permit(:title, :text, :featured_image, :user_id)
    end
    def postarticle
        author = User.find_by(name: params[:user_name]).id
        category = params[:category]
        temp = Category.find_by(name: category)
        if(temp.nil?)
            new_cat = Category.create(name: params[:category])
        end
        render json: Article.create(title: params[:title], description: params[:description], content: params[:content], user_id: author, category_id: temp.id)
    end

    def editarticle
        render json: Article.find(params[:article_id]).update(title: params[:title], description: params[:description], content: params[:content])
    end
    def deletearticle
        article = Article.find(params[:article_id])
        Article.delete(article)
    end
end
