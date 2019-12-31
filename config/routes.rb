Rails.application.routes.draw do
  
  scope :admin, module: 'quip/admin', as: :admin do
    resources :quip_apps do
      resources :quip_threads
    end
  end
  
end
