Rails.application.routes.draw do
  # resources :likes
  # resources :comments
  # resources :users
  # resources :categories
  # resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # POST /signup --> Sign's up a new user
  post '/signup', to: 'users#signupuser'
  # POST /login --> Logs in user into the website
  post '/login', to: 'authentication#login'
  # DELETE /logout --> Logs out the users from website
  delete '/logout', to: 'authentication#logout'


  # POST /authenticate --> This authenticates whether the username, password are correct or not

  get '/articles/user/:user_id', to: 'articles#showarticlesbyuser'

  # GET /articles --> It shows all the articles
  get 'articles', to: 'articles#showall'
  # POST /user/:user_name/createarticle --> Posts an article
  post '/user/:user_id/createarticle', to: 'articles#postarticle'

  put '/user/:article_id/editarticle', to: 'articles#editarticle'

  delete '/user/:user_id/:article_id/deletearticle', to: 'articles#deletearticle'

  put '/user/:user_id/edituser', to: 'users#editusercred'

  # Defines the root path route ("/")
  # root "articles#index"
end
