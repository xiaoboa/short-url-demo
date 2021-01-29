Rails.application.routes.draw do
  post '/s', to: 'short_urls#create', as: :short_urls
  get  '/s/:short_id', to: 'short_urls#show', as: :short_url

  get   '/a/:admin_id', to: 'admin/short_urls#show',  as: :admin_short_url
  put   '/a/:admin_id', to: 'admin/short_urls#update'
  patch '/a/:admin_id', to: 'admin/short_urls#update'

  root "short_urls#new"
end
