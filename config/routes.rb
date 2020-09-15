Rails.application.routes.draw do
  # get 'article', to: 'articles#article'
  root 'pages#home'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new] 
end
