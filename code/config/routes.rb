Rails.application.routes.draw do

  post "/inspect", to: "tag_map#inspect"

  # You can have the root of your site routed with "root"
  root 'tag_map#index'

end
