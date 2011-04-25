Grouptalk::Application.routes.draw do

  devise_for :admins

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  #customize devise routes
  devise_for :users, :controllers => {:registrations => "user/registrations", :sessions => "user/sessions", :passwords => "user/passwords"}

  devise_scope :user do
    get "sign_in",              :to => "user/sessions#new",       :as => :new_user_session
    post "sign_in",              :to => "user/sessions#create",       :as => :user_session
    get "sign_out",             :to => "user/sessions#destroy",   :as => :destroy_user_session

    put "password",      :to => "user/passwords#create",   :as => :user_password
    get "password/new",  :to => "user/passwords#new",      :as => :new_user_password
    get "password/edit",      :to => "user/passwords#edit",     :as => :edit_user_password
    post "password", :to => "user/passwords#update"

#    get "cancel",             :to => "user/registrations#cancel",  :as => :cancel_user_registration
#    post "",             :to => "user/registrations#create",  :as => :user_registration
#    get "sign_up",             :to => "user/registrations#new",  :as => :new_user_registration
#    get "edit",             :to => "user/registrations#edit",  :as => :edit_user_registration
  end

  resources :posts
  resources :groups
  resources :users

#  match '/search' => 'home#search', :as => :search
  match '/group' => 'home#groups', :as => :group_home
  match '/user' => 'home#users', :as => :user_home

#  match '/friends' => 'users#friends', :as => :friends_posts

  match '/post/:post_id' => 'posts#index', :as => :post_info

  match '/group/:group_id' => 'groups#index', :as => :group_info
  match '/group/:group_id/posts' => 'groups#posts', :as => :group_posts
  match '/group/:group_id/users' => 'groups#users', :as => :group_users
  match '/group/:group_id/toggle_follow' => 'groups#toggle_follow', :as => :toggle_follow_group

  match '/user/:username' => 'users#index', :as => :user_info
  match '/user/:username/posts' => 'users#posts', :as => :user_posts
  match '/user/:username/groups' => 'users#groups', :as => :user_groups
  match '/user/:username/remove_friend' => 'users#remove_friend', :as => :remove_friend
  match '/user/:username/toggle_follow' => 'users#toggle_follow', :as => :toggle_follow_user
end
