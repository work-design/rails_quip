Rails.application.routes.draw do

  scope :admin, module: 'quip/admin', as: :admin do
    resources :quip_apps do
      resources :posts do
        post :sync, on: :collection
      end
    end
  end

end
