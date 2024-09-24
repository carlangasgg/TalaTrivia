Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :trivias do
    resources :trivia
    get 'players', to: 'trivia#players'
    get 'select', to: 'trivia#select_trivia'
    get '/:id/start', to: 'trivia#start'
    get '/:id/players', to: 'trivia#players_trivia'
    post '/:id/user/:uid', to: 'trivia#add_user_to_trivia'
    delete '/:id/user/:uid', to: 'trivia#remove_user_to_trivia'
    get '/:id/questions', to: 'trivia#show_questions'
  end

  namespace :questions do
    resources :questions
    resources :options
    get '/:id/options', to: 'questions#show_options'
  end

  namespace :answers do
    post 'submit', to: 'answers#submit'
    get '/:uid/show_answers', to: 'answers#show_answers'
    get '/:uid/scoreboard', to: 'answers#scoreboard'
  end
end
