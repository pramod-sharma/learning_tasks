Ham::Application.routes.draw do

  controller :sessions do
    get "login" => :new
    # FIXME_KD: verb and routes are not meaningful
    # Comment:- Need to discuss
    delete "logout" => :destroy
  end

  post '/auth/google/callback', to: 'sessions#create'

  
  resources :projects do
    resources :monthly_billings, only: [:edit, :create, :update, :destroy, :index]
    member do
      constraints(project_id: /\d+/) do
        # FIXME_KD: use member block
        # Fixed
        post 'deactivate'
        post 'activate'
      end
      # FIXME_KD: use member block
      # Fixed
      post "update_monthly_billing"
      post "delete_monthly_billing"
    end
  end

  resources :employees do
    collection do
      # post "update_admin"
      post 'sort_list'
    end
    constraints(employee_id: /\d+/) do
      # FIXME_KD: use member block
      # Fixed
      member do
        post 'relieve'
        # post 'activate'
      end
    end
  end  

  resources :report do
    collection do
      get "utilization"
      get "revenue"
      post "generate"
      get "revenue_projection"
      post 'relieving_employees'
      get 'utilization_table'
      get 'pie_report'
      get 'billings'
      get 'update_report'
    end
  end
  
  resources :project_assignments do
    post 'relieve', on: :member
  end
  
  root to: 'report#utilization', as: :admin
  resources :teams
end
