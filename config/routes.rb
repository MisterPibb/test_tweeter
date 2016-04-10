Rails.application.routes.draw do
  root "posts#index"

  resources :users, only: [:index]
  resources :posts
  resources :comments, except: [:index, :show]
end


#New = Create#
#Edit = Update#
#Show = Shows Record#
#Index = Show Collection of Records#
