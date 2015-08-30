Rails.application.routes.draw do

  root 'home#index'
  get 'why', to: 'home#why', as: 'why'
  get 'contact', to: 'home#contact', as: 'contact'

  # feelings routes
  post 'feeling', to: 'feelings#create'

  # session routes
  post 'session/create', to: 'sessions#create'
  put 'session/end', to: 'sessions#end'
  
end
