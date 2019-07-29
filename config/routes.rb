Rails.application.routes.draw do
  resources :pages
  namespace :api do
    resources :tenants, param: :tenant_id, except: [:new]
  end
end
