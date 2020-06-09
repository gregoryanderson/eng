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
        # get '/:merchant_id/favorite_customer', to: 'favorite_customer#show'
        # get '/revenue', to: 'revenue#show'
        # get '/most_revenue', to: 'most_revenue#index'
        # get '/random', to: 'random#show'
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

      namespace :invoice_items do
        get '/', to: 'invoice_items#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        # get '/random', to: 'random#show'
        get '/:id', to: 'invoice_items#show'
        get '/:id/item', to: 'item#show'
        get '/:id/invoice', to: 'invoice#show'
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
        # get '/random', to: 'random#show'
      end

      namespace :customers do
        get '/', to: 'customers#index'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
        # get '/random', to: 'random#show'
        get '/:id', to: 'customers#show'
        # get '/:id/favorite_merchant', to: 'favorite_merchant#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
        post '/new_customer', to: 'customers#create'
        delete '/:id/delete', to: 'customers#destroy'
      end

      namespace :transactions do 
        get '/', to: 'transactions#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/:id', to: 'transactions#show'
        get '/:id/invoice', to: 'invoice#show'
      end
    end
  end
end
