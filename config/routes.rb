Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "background/users#index"

  namespace :foreground do 
	resources :users  	
  end

  namespace :background  do
    resources :users
  end

end
