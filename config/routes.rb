Redpencil::Application.routes.draw do
  root :to => 'static#index'
  
  resources :posts, :except => [:edit, :update]
  
  get ':action' => 'static#:action'
end