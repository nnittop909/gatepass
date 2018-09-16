Rails.application.routes.draw do
	get "monitoring/index"
  get "dashboard/index"
	resources :students do
    resources :guardians, module: 'students'
    resources :profile_photos, module: 'students'
    resources :addresses, only: [:new, :create, :edit, :update], module: 'students'
    resources :courses, only: [:edit, :update], module: 'students'
    resources :statuses, only: [:edit, :update], module: 'students'
    resources :mobiles, only: [:edit, :update], module: 'students'
    resources :emails, only: [:edit, :update], module: 'students'
    resources :id_numbers, only: [:edit, :update], module: 'students'
    resources :id_cards, only: [:edit, :update], module: 'students'
		get :autocomplete_student_full_name, on: :collection
    match "/info" => "students#info", as: :info, via: [:get], on: :member
    match "/report" => "students#report", via: [:get], on: :collection
    match "/update_options" => "students#update_options", as: :update_options, via: [:get], on: :member
    match "/report" => "students#report", via: [:get], on: :collection
    match "/full_template" => "students#full_template", as: :full_template, via: [:get], on: :collection
    match "/initial_template" => "students#initial_template", as: :initial_template, via: [:get], on: :collection
    match "/export" => "students#export", as: :export, via: [:get], on: :collection
    collection { post :import}
	end
	resources :employees do
		get :autocomplete_employee_full_name, on: :collection
	end
	resources :settings
	resources :reports
  resources :student_imports, only: [:new, :create]
  resources :profile_photos
  resources :courses

  devise_for :users, :controllers => { :registrations => "users", sessions: "users/sessions" }
  
  devise_scope :user do
    authenticated :user do
      root 'students#index', as: :authenticated_root
    end

    unauthenticated do
      root 'monitoring#index', as: :unauthenticated_root
    end
  end
  resources :users do 
  	get :autocomplete_user_full_name, on: :collection
    match "/info" => "users#info", as: :info, via: [:get], on: :member
    match "/activities" => "users#activities", as: :activities, via: [:get], on: :member
  end
end
