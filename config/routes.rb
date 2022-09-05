Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "v1/articles"
  # get 'about', to: "pages#about"
  namespace :v1 do
    resources :articles
  end
end
