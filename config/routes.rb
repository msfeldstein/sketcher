Illustratingjs::Application.routes.draw do
  get "sketch/index"

  get "sketch/show"

  get "sketch/new"

  get "sketch/edit"

  get "sketch/create"

  get "sketch/update"

  get "sketch/destroy"

  resources :sketches
  root :to => 'editor#view'
end
