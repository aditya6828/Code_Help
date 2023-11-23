Rails.application.routes.draw do
  get '/index', to: 'home#index'
  get '/registration', to: 'users#new'
  get '/login', to: 'login#login'
  post '/login', to: 'login#verifyOTP'

  get '/loginConfirm', to: 'login#loginConfirm'
  post '/postlogin', to: 'login#postlogin'

  get '/user_detail', to: 'login#user_detail'
  post '/user_detail', to: 'login#user_detail'
  
  get '/user', to: 'users#new'
  resources :users, only: [:new, :create]
  root 'users#new'
  # get 'confirmation/:token', to: 'users#confirmation', as: 'confirmation'
  get '/confirmEmail', to: 'users#confirmEmail'
  post '/postEmail', to: 'users#postEmail'
  # config/routes.rb
  # post 'process_confirmation', to: 'users#process_confirmation', as: 'process_confirmation'

  get '/newCourse', to: 'course#new'
  post '/courses', to: 'course#create'


  get '/index2', to:'home#index2'
  get '/courses', to: 'course#index'

  post '/course/payment', to: 'payments#create'
end
