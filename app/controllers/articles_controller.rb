class ArticlesController < ApplicationController
    skip_before_action :authenticate_request
    def showall
        temp = Article.all
        render json: temp.select(:id, :title)
    end
    def postparams
        params.required(:article).permit(:title, :text, :featured_image, :user_id)
    end
    def postarticle
        Article.create(params[:postparams])
    end
end
