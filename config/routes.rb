Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lists do
    collection do
      get :trash
    end

    member do
      put :restore
      delete :delete
    end
  end

  resources :items, only: [] do
    collection do
      get :trash
    end
  end
end
