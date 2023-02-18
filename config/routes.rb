Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :users
  resources :categories
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # POST /signup --> Sign's up a new user
  post 'signup', to: 'users#signup'



  # POST /authenticate --> This authenticates whether the username, password are correct or not
  post 'authenticate', to: 'authentication#authenticate'
  # GET /articles --> It shows all the articles
  get '/article_all', to: 'articles#showall'
  # POST /article --> Posts an article
  post 'article', to: 'articles#postarticle'
  # GET /:user_id/articles --> Get article by author
  get '/:user_id/articles', to: 'articles#showpostbyid'


  
  # Defines the root path route ("/")
  # root "articles#index"
end
