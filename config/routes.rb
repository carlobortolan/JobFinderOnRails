Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v0 do
      post 'user', to: 'registrations#create'
      get 'user/verify', to: 'registrations#verify'
      post 'user/auth/token/refresh', to: 'authentications#create_refresh'
      post 'user/auth/token/access', to: 'authentications#create_access'

    end
  end

  resources :jobs do
    resources :applications
  end

  get 'jobs/(/:job_id)/applications/(/:application_id)/accept', :to => 'applications#accept', as: 'job_application_accept'
  get 'jobs/(/:job_id)/applications/(/:application_id)/reject', :to => 'applications#reject', as: 'job_application_reject'
  get 'jobs/(/:job_id)/applications_reject_all', :to => 'applications#reject_all', as: 'job_applications_reject_all'
  delete 'jobs/(/:job_id)/applications/(/:application_id)' => 'applications#destroy'

  get 'user/applications', :to => 'applications#own_applications', as: 'own_applications'
  get 'user/jobs', :to => 'jobs#own_jobs', as: 'own_jobs'

  get 'find_jobs', :to => 'jobs#find', as: 'jobs_find'
  post 'find_jobs', :to => 'jobs#parse_inputs'

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

  get 'reviews', :to => 'reviews#index', as: 'reviews'
  get 'reviews/(/:user_id)', :to => 'reviews#for_user', as: 'reviews_user'
  post 'reviews', :to => 'reviews#index'
end
