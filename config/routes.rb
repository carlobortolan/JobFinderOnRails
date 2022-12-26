Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "jobs#index"

  resources :jobs do
    resources :applications
  end

  get 'jobs/(/:job_id)/applications/(/:application_id)/accept', :to => 'applications#accept', as: 'job_application_accept'
  get 'jobs/(/:job_id)/applications/(/:application_id)/reject', :to => 'applications#reject', as: 'job_application_reject'
  get 'jobs/(/:job_id)/applications_reject_all', :to => 'applications#reject_all', as: 'job_applications_reject_all'
  get 'find_jobs', :to => 'jobs#find', as: 'jobs_find'
  post 'find_jobs', :to => 'jobs#parse_inputs'

  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'

  delete 'logout', to: 'sessions#destroy'

  get 'password', to: 'passwords#edit', as: 'edit_password'
  patch 'password', to: 'passwords#update'

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'

  # get 'exit', to: 'sessions#destroy', as: :logout
  # get ':username', to: 'users#show', as: :user
  # resources :users
  # Defines the root path route ("/")
end
