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
  get 'jobs-find', :to => 'jobs#find', as: 'jobs_find'
  get 'exit', to: 'sessions#destroy', as: :logout
  get ':username', to: 'users#show', as: :user
  resources :users
  # Defines the root path route ("/")
end
