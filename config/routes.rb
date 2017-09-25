Rails.application.routes.draw do
  resources :loans, defaults: {format: :json} do
    resources :payments, only: [:create]
  end
end
