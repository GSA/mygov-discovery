Discovery::Application.routes.draw do
  get '/pages/no-js', :to => 'pages#no_js', :as => "pages_no_js"  
  get '/pages/lookup', :to => 'pages#lookup', :as => "pages_lookup"

  resources :pages do
    resources :comments, :only => [:index, :create]
    resources :ratings, :only => [:create]
  end
  
  resources :tags, :only => [:index, :show]
  
  match '/pages/:id' => 'Application#cors', :via => :options
  match '/pages/:id/comments' => 'Application#cors', :via => :options
  match '/pages/:id/ratings' => 'Application#cors', :via => :options

  root :to => 'home#readme'

  require 'resque/server' 
  mount Resque::Server.new, :at => "/resque"

end
