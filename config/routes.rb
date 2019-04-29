Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "background/users#index"

  resource :auth, only: [] do 
    collection do 
      delete :sign_out
      get :sign_in
      get :sign_up
      post :do_sign_in
      post :do_sign_up
    end
  end

  namespace :foreground do 
    resources :users  	
  end

  namespace :background  do
    resources :users do 
      collection do 
        post :search
      end
    end

    resources :menus do 
      collection do 
        get :pundit_groups
        post :search
      end
    end
          
    resources :roles do 
      collection do 
        post :search
      end
      member do 
        get :menus
        get :pundit_groups
        post :save_menus
        post :save_pundit_groups
      end
    end
    
  end #background end

end
