Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      
      namespace :merchants do
        get '/', to: 'merchants#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id', to: 'merchants#show'
        get '/:merchant_id/items', to: 'items#index'
      end

      namespace :invoices do 
        get '/', to: 'invoices#index'
        get '/:id', to: 'invoices#show'
      end 
      
      resources :items, only: [:index, :show]
    end
  end
end
