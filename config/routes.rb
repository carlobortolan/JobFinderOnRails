Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "jobs#index"

  # get "/jobs", to: "jobs#index"
  resources :jobs do
    resources :applications
  end

  get 'jobs/:job_id/applications/:application_id/accept', :to => 'applications#accept'
  get 'jobs/:job_id/applications/:application_id/reject', :to => 'applications#reject'

  # Defines the root path route ("/")
end
