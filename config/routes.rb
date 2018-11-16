Rails.application.routes.draw do
  get 'booster/index'
  get 'booster/show'
  get 'set/index'
  get 'home/index'
  root 'set#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
