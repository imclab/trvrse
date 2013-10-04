Tripit::Application.routes.draw do

  get 'verses/mine'

  resources :verses

  resources :points

  resources :locations

  resources :lists do
    resources :list_items
  end

  get "sessions/create", as: "login"
  get "sessions/authorize"
  get "users/new"
  get "sessions/destroy", as: "logout"

  get "home/index"

  match "ajax/search/:search" => "ajax#search", :action => :get
  get "ajax/trips"
  get "ajax/locations"
  match "ajax/like/:id" => "ajax#like", :as => :like

  match "ajax/location/:id" => "ajax#location", :action => :get

  match "map" => "home#map"

  resources :trips do
    resources :comments
    collection do
      get 'sync'
    end
    member do
      get 'comment'
    end
  end

  match "feed" => "home#feed"
  match "tag/:tag" => "home#tag", :as => :tag
  match "guidebook" => "home#guidebook"


  root :to => 'home#map'

  get ":username" => "users#show", :as => :user
end
