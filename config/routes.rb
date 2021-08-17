Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks, except: :show
  devise_for :users
  patch "toggle/:id", to: "tasks#toggle", as: :toggle
  delete "all", to: "tasks#tasks_delete", as: :tasks_to_delete
end
