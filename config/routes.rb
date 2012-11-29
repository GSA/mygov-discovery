Discovery::Application.routes.draw do
  
  resources :ratings
  resources :tags, :only => [:show, :index]
  
  devise_for :users

  require 'resque/server' 
  mount Resque::Server.new, :at => "/resque"
    
  root :to => 'home#mygov_bar'
  get '/pages/lookup', :to => 'pages#lookup', :as => "pages_lookup"

end
