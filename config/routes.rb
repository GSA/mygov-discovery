Discovery::Application.routes.draw do
  
  get '/pages/lookup', :to => 'pages#lookup', :as => "pages_lookup"
  resources :pages, :member => {:rate => :post}
  
  require 'resque/server' 
  mount Resque::Server.new, :at => "/resque"

  root :to => 'home#readme'

end
