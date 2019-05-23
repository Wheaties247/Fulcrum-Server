Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'allRecords', :to => 'results#all'
  # all post requests to allRecords endpoint get redirected 
  # to results controllers all method
  post 'login', :to => 'users#login'
  # all post requests to login endpoint get redirected 
  # to users controllers login method
  post 'register', :to => 'users#register'
   # all post requests to register endpoint get redirected 
  # to users controllers register method
  post 'lost', :to => 'users#lostCreds'
  # all post requests to lost endpoint get redirected 
  # to users controllers lostCreds method
  post 'makeEntry', :to => 'results#entry'
  # all post requests to makeEntry endpoint get redirected 
  # to users controllers entry method
  
  # resources :users
  # resources denote active records to be used

end
