Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "jobs#index"

  # get "/jobs", to: "jobs#index"
  resources :jobs do
    resources :applications
  end
  # Defines the root path route ("/")
end
