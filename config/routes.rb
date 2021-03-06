Homeschooling::Application.routes.draw do
  devise_for :users, :controllers => {
              :registrations => "users/registrations",
              :passwords => "users/passwords",
              :omniauth_callbacks => "users/omniauth_callbacks"
            }

  resources :users, :only => :show do
    get 'tags', :on => :member
  end
  get 'tags/:tag', to: 'users#tags', as: :tag
  resources :countries, :only => [:new, :create]

  get 'near_coordinates' => "users#near_coordinates"
  get 'user_github_repos' => "users#github_repos"
  get "countries_selection" => "countries#countries_selection"
  get "search/index"
  get "about/index"
  get "home/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
