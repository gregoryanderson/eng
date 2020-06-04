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
      
      resources :items, only: [:index, :show]

      namespace :invoices do 
        get '/find_all', to: 'find#index'
        get 'find', to: 'find#show'
        get '/:id/items', to: 'items#index'
        get '/:id/merchant', to: 'merchant#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/customer', to: 'customer#show'
        get '/:id', to: 'invoices#show'
        get '/', to: 'invoices#index'
      end
      
      namespace :invoice_items do 
      end 
    end
  end
end
