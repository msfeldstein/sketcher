Illustratingjs::Application.routes.draw do
  resources :sketches
  root :to => 'sketches#index'
end
