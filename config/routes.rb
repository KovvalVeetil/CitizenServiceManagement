Rails.application.routes.draw do
  devise_for :users
  resources :service_requests
end
