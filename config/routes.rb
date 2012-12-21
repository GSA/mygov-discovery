Discovery::Application.routes.draw do
  get '/pages/no-js', :to => 'pages#no_js', :as => "pages_no_js"
  get '/pages/lookup', :to => 'pages#lookup', :as => "pages_lookup"
  resources :pages, :only => [:index, :show, :create, :update] do
    resources :comments, :only => [:index, :create]
    resources :ratings, :only => [:create]
  end
  match '/pages/:id' => 'Application#cors', :via => :options
  match '/pages/:id/comments' => 'Application#cors', :via => :options
  match '/pages/:id/ratings' => 'Application#cors', :via => :options
  match '/tags/:id' => 'tags#show'
  root :to => 'home#readme'
end
