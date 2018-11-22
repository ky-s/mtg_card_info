Rails.application.routes.draw do
  get 'beta_test/index'
  get 'booster/show'
  get 'set/index'
  get 'set/show'
  get 'set/fetch'
  get 'set/fetch_cards'
  get 'set/fetch_cards_image'
  get 'home/index'
  root 'set#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
