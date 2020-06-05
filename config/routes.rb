Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      
      namespace :merchants do
        get '/', to: 'merchants#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id', to: 'merchants#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end
      
      namespace :items do 
        get '/', to: 'items#index'
        # get '/most_revenue', to: 'most_revenue#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        # get '/random', to: 'random#show'
        get '/:id', to: 'items#show'
        # get '/:id/best_day', to: 'best_day#show'
        get '/:id/merchant', to: 'merchant#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
      end

      namespace :invoices do 
        get '/find_all', to: 'find#index'
        get 'find', to: 'find#show'
        get '/:id/items', to: 'items#index'
        get '/:id/merchant', to: 'merchant#show'
        get '/:id/transactions', to: 'tranactions#show'
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
