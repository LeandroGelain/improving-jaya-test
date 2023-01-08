Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  # webhook route to create issue
  post 'events/', to: 'events#create'

  # route to get events by issue
  get 'issues/:id/events', to: 'events#index'
end
