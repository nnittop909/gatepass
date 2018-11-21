Rails.application.routes.draw do

	get "monitoring/index"
  get "help_desk/index"

	resources :students do
    resources :guardians, module: 'students' do
      match "/update_options" => "guardians#update_options", via: [:get], on: :member
    end
    resources :profile_photos, module: 'students'
    resources :addresses, only: [:new, :create, :edit, :update], module: 'students'
    resources :courses, only: [:edit, :update], module: 'students'
    resources :statuses, only: [:edit, :update], module: 'students'
    resources :mobiles, only: [:edit, :update], module: 'students'
    resources :emails, only: [:edit, :update], module: 'students'
    resources :id_numbers, only: [:edit, :update], module: 'students'
    resources :rfid_cards, only: [:edit, :update], module: 'students'
		get :autocomplete_student_full_name, on: :collection
    match "/info" => "students#info", as: :info, via: [:get], on: :member
	end

  resources :reports do
    match "/render_pdf" => "reports#render_pdf", via: [:get], on: :collection
    match "/student_template" => "reports#student_template", via: [:get], on: :collection
    match "/render_excel" => "reports#render_excel", via: [:get], on: :collection
    match "/export_student_records" => "reports#export_student_records", via: [:get], on: :collection
  end

  namespace :migrations do
    resources :student_records, only: [:upload, :delete_all] do
      match "/upload" => "student_records#upload", via: [:post], on: :collection
      match "/delete_all" => "student_records#delete_all", via: [:get], on: :collection
    end

    resources :student_photos, only: [:upload] do
      match "/upload" => "student_photos#upload", via: [:post], on: :collection
    end
  end

  resources :employees do
    get :autocomplete_employee_full_name, on: :collection
  end

  namespace :system_settings do
    resources :courses, only: [:new, :create, :edit, :update]
    resources :configurations, only: [:edit, :update]
  end

  resources :settings, only: [:index]

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
    resources :passwords, only: [:edit, :update], module: 'users'
  	get :autocomplete_user_full_name, on: :collection
    match "/info" => "users#info", as: :info, via: [:get], on: :member
    match "/activities" => "users#activities", as: :activities, via: [:get], on: :member
  end
end
