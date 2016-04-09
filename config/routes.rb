Rails.application.routes.draw do
  root "posts#index"

  resources :posts
end


#New = Create#
#Edit = Update#
#Show = Shows Record#
#Index = Show Collection of Records#
