Discovery::Application.routes.draw do

  get '/pages/no-js', :to => 'pages#no_js', :as => "pages_no_js"  
  get '/pages/lookup', :to => 'pages#lookup', :as => "pages_lookup"
  resources :pages, :member => {:rate => :post}
  
  match '/pages/:id' => 'Application#cors', :via => :options

  match '/tags/:id' => 'tags#show'

  root :to => 'home#readme'

  require 'resque/server' 
  mount Resque::Server.new, :at => "/resque"

end
