#encoding: utf-8
module LxhApi
  class TestAPI < Grape::API
    version 'v1'

    resource :test do
      desc '测试移动网络下http返回状态码 是否正常'
      params do
        requires :code, desc: 'http状态码 比如 403/405'
        # optional :text
      end
      get :halt do
        { :code => params[:code]}
      end

      desc '测试qq 返回'
      get :qq do
        begin
          Timeout::timeout(10) do
            url = "https://graph.qq.com/user/get_simple_userinfo?openid=6EE1BD53897D02AFE56DB22023E5ACE1&oauth_consumer_key=100524968&access_token=20692183EB7543229A715D83358875A8"
            result = JSON.parse(RestClient.get(url))
            result
          end
        rescue Timeout::Error
          halt403(99,'qq访问超时，请稍后重试',{})
        end
      end

      desc '模拟登录'
      params do
        requires :id, :type => Integer
        # requires :code, :desc => "2461c10958ea6dec6ceb50b123dfdfg54gdfj"
      end
      get :login do
        # UserMailer.welcome()
        # error!('Unauthorized', 401) unless params[:code].eql? '2461c10958ea6dec6ceb50b123dfdfg54gdfj'
        env['rack.session'][:user_id] = params[:id]

        { :user_id => params[:id]}
      end


      desc '这里写描述3'
      params do
        optional :text, type: String, regexp: /^[a-z]+$/
      end
      get :auth do
        authenticate!
        current_user
      end

    end

  end
end



