Illustratingjs::Application.routes.draw do
  resources :sketches do
  	member do
  		get 'embed'
  	end
  end
  root :to => 'sketches#index'
end
