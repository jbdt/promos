Rails.application.routes.draw do
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root 'home#index'

  get 'daily_view_preview/:id', to: 'home#daily_view_preview', as: 'daily_view_preview'
  get 'view_template_preview/:id', to: 'home#view_template_preview', as: 'view_template_preview'
  get 'base_template_preview/:id', to: 'home#base_template_preview', as: 'base_template_preview'
end
