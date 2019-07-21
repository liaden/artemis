Rails.application.routes.draw do
  namespace :api do
    resources :tenants, param: :tenant_id, except: [:new]
  end
end
