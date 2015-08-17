Rails.application.routes.draw do

  root 'home#index'

  # feelings routes
  post 'feeling', to: 'feelings#create'

  
end
