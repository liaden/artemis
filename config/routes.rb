Rails.application.routes.draw do
  namespace :api do
    resources :tenants, except: [:new]
  end
end
