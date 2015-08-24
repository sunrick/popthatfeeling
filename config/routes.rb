Rails.application.routes.draw do

  root 'home#index'

  # feelings routes
  post 'feeling', to: 'feelings#create'

  # session routes
  post 'session/create', to: 'sessions#create'
  put 'session/end', to: 'sessions#end'
  
end
