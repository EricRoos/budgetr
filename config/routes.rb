# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  post '/graphql', to: 'graphql#execute'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  #
  root to: 'projects#index'
  resources :projects do
    resources :item_groups do
      resources :items
    end
  end

  post 'versions/:id/restore', to: 'versions#restore', as: 'restore_version'

  get '*unmatched_route', to: 'application#route_not_found'
end
