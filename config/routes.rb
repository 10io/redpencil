Redpencil::Application.routes.draw do
  
  root :to => 'static#index'
  
  resources :posts, :except => [:edit, :update]
  
  get "users/login"

  get "users/check"

  get "users/logout"
  
  get ':action' => 'static#:action'
  
end