Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "jobs#index"

  # get "/jobs", to: "jobs#index"
  resources :jobs do
    resources :applications
  end

  get 'jobs/(/:job_id)/applications/(/:application_id)/accept', :to => 'applications#accept', as: 'job_application_accept'
  get 'jobs/(/:job_id)/applications/(/:application_id)/reject', :to => 'applications#reject', as: 'job_application_reject'
  get 'jobs/(/:job_id)/applications_reject_all', :to => 'applications#reject_all', as: 'job_applications_reject_all'
  get 'find_jobs', :to => 'jobs#find', as: 'jobs_find'
  post 'find_jobs', :to => 'jobs#parse_inputs'
  post 'find_jobs', :to => 'jobs#parse_inputs', as: 'jobs_find_jobs'
  #http://localhost:3000/find_jobs?location=latitude=1.0&longitude=1.0&radius=1.0
  get 'exit', to: 'sessions#destroy', as: :logout
  get ':username', to: 'users#show', as: :user
  resources :users
  # Defines the root path route ("/")
end
