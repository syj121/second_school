Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "background/users#index"

  #cable路由
  mount ActionCable.server => "/cable"


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
      post :index_search
    end

    resources :menus do 
      collection do 
        get :pundit_groups
      end
    end
          
    resources :roles do
      member do 
        get :menus
        get :pundit_groups
        post :menus_save
        post :pundit_groups_save
      end
    end
    
  end #background end

end
