Discovery::Application.routes.draw do
  get '/pages/no-js', :to => 'pages#no_js', :as => "pages_no_js"
  resources :pages, :only => [:index, :show, :create, :update] do
    resources :comments, :only => [:index, :create]
    resources :ratings, :only => [:create]
  end
  
  resources :tags, :only => [:index, :show]
  
  match '/pages/:id' => 'Application#cors', :via => :options
  match '/pages/:id/comments' => 'Application#cors', :via => :options
  match '/pages/:id/ratings' => 'Application#cors', :via => :options

  root :to => 'home#readme'
  
end
