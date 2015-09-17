Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
root "ingredients#new"
resources :users
post '/sign_up'=>"users#sign_up"
get '/user_confirmation'=>"users#user_confirmation"
post '/log_in'=>"sessions#log_in"
post '/forgot_password'=>"password_resets#forgot_password" 
post '/access_code'=>"password_resets#access_code"
post '/update_password'=>"password_resets#update_password"
post '/log_out'=>"sessions#log_out"
get '/subscription'=>"infos#subscription"
resources :password_resets

post '/my_profile' => "users#my_profile"
post '/edit_profile' => "users#edit_profile"
post '/add_member' => "members#add_member"
post '/manage_profile'=> "members#manage_profile"
post '/select_member' => "members#select_member"
post '/edit_member' => "members#edit_member"
post '/remove_member' => "members#remove_member"
post '/add_preventive' => "preventives#add_preventive"
post '/remove_preventive' => "preventives#remove_preventive"
post '/contact_us' => "infos#contact_us"
get  '/about_us' => "infos#about_us"
get  '/terms_conditions' => "infos#terms_conditions"
post '/ingredients_list'=>"ingredients#ingredients_list"
post '/search_ingredients' => "ingredients#search_ingredients"
post '/add'=>"ingredients#add"
post 'upload_file' => "ingredients#upload_file"
post '/scan_upc'=> "ingredients#scan_upc"
post '/search_product_by_name' => "ingredients#search_product_by_name"
post '/select_searched_product' => "ingredients#select_searched_product"
post '/scan_history'=>"users#scan_history"
post '/recent_searched_product' => "users#recent_searched_product"
post '/scan_result'=>"preventives#scan_result"
# post '/member_preventives'=>"members#member_preventives"
# post '/user_preventives'=>"users#user_preventives"

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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
