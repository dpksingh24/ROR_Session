Rails.application.routes.draw do

  namespace :v1 do
    # resources :articles, :users
    resources :users do
      resources :articles
    end
    resources :articles
    # get "users/:id/articles", to: 'users#user_articles'
  end

end
