Rails.application.routes.draw do
  root to: "admin/dashboard#index"
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
