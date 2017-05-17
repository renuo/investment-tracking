Rails.application.routes.draw do
  get 'home/check'
  get 'home/index'

  root 'home#index'

  constraints format: :json do
    get 'api/v1/data', to: 'home#index', as: :data
  end
end
