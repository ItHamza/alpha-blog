Rails.application.routes.draw do
  # get 'article', to: 'articles#article'

  resources :articles, only: [:show, :index, :new, :create]
end
