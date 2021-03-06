Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'homeworks/:id/delete', to: 'homeworks#destroy'
  
  post '/notifications', to: 'homeworks#notify'
  get '/notifications', to: 'homeworks#notify'
  
  resources :homeworks
  resources :sessions, only: [:create, :destroy]
  
  root to: "pages#home"
end
