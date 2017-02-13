Rails.application.routes.draw do
  get 'home/check'
  get 'home/index'

  get 'time_entries/index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
