Rails.application.routes.draw do
  root 'todos#index'

  namespace :api do
    namespace :v1 do
      resource :todos
    end
  end
end
