Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users

  authenticated :user do
    root 'rooms#show', as: "authenticated_root"
  end

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
