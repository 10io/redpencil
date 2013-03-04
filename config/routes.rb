Redpencil::Application.routes.draw do
  resources :posts, :except => [:edit, :update]
end