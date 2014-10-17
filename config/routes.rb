Rails.application.routes.draw do

  # resource :weixin do
  #   collection do
  #     get :welcome
  #     get :oauth
  #   end
  #
  #   member do
  #
  #   end
  # end

  require 'api'
  #root :to => redirect('http://www.shiyimm.com')
  mount WxApi::API => '/'
end
