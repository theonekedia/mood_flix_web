Rails.application.routes.draw do
  resources :authentications
  namespace :posts do
    resources :categories
  end
  root to: 'website#index'
  
  resources :device_registrations
  resources :posts do
    resources :invites
    resources :statuses
  end
  resources :statuses
  resources :users
  ############ MOBILE API ##############
  namespace :api do
    namespace :v0 do
      match 'mobile/register'             => 'mobile_api#register',           :via => [:put, :get, :post] 
      match 'mobile/user/login'           => 'mobile_api#login',              :via => [:put, :get, :post] # create a new user
      match 'mobile/notifications'        => 'mobile_api#notifications',      :via => [:put, :get, :post] # create a new user
      match 'mobile/send_notifications'   => 'mobile_api#send_notifications', :via => [:put, :get, :post] # create a new user
      match 'mobile/location'             => 'mobile_api#location',           :via => [:put, :get, :post] # fetch location 
      match 'mobile/cities'               => 'mobile_api#cities',             :via => [:put, :get, :post]
      match 'mobile/new_post'             => 'mobile_api#create_post',        :via => [:put, :get, :post]
      match 'mobile/all_post'             => 'mobile_api#all_post',           :via => [:put, :get, :post]
      match 'mobile/category'             => 'mobile_api#category_all',       :via => [:put, :get, :post]
      match 'mobile/favlist'              => 'mobile_api#user_favlist',       :via => [:put, :get, :post]
      match 'mobile/user/details'         => 'mobile_api#user_details',       :via => [:put, :get, :post]
      match 'mobile/:city_id/localities'  => 'mobile_api#city_localities',    :via => [:put, :get, :post]
    end

  end  
end
