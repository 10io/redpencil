Redpencil::Application.routes.draw do
  
  root :to => 'static#index'
  
  resources :posts, :except => [:edit, :update]
  
  post "users/login"

  get "users/check"

  post "users/logout"
  
  get ':action' => 'static#:action'
  
end