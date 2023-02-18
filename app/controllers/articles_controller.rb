class ArticlesController < ApplicationController
    before_action :authenticate_request
    def showall
        render json: Article.all
    end
    def postparams
        params.required(:article).permit(:title, :text, :featured_image, :user_id)
    end
    def postarticle
        Article.create(params[:postparams])
    end
end
