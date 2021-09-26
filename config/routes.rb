Rails.application.routes.draw do
  
  get "reservations/home" => "reservations#home"

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  
  
  get "rooms/index" => "rooms#index"
  get "rooms/new" => "rooms#new"
  get "rooms/search" => "rooms#search"
  get "rooms/:id/detail" => "rooms#detail"
  post "rooms/create" => "rooms#create" 
 
  get "bookings/index" => "bookings#index"
  post "bookings/confirm" => "bookings#confirm"
  post "bookings/reconfirm" => "bookings#reconfirm"
  
  resources :users
  resources :bookings
  
  root "reservations#home"
  
end
