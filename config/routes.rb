Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'home#top'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :lists
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
