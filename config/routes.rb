Rails.application.routes.draw do
  # get 'article', to: 'articles#article'
  root 'pages#home'
  resources :articles
end
