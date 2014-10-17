#encoding: utf-8
# require 'helpers'
# require 'helpers_encode'
# require 'helpers_error'

require 'test_api'

require 'api_weixin'


module WxApi
  class API < Grape::API
    # helpers APIHelpers
    # helpers HelpersEncode
    # helpers HelpersError
    #use Rack::Session::Cookie
    #prefix ''
    # format :xml
    # content_type :json, 'application/json'
    # content_type :xml, "text/xml"

    before do
      #header['Access-Control-Allow-Origin'] = '*'
      #header['Access-Control-Request-Method'] = '*'
      #Rails.logger.info "#{env}"
      agent = env['HTTP_USER_AGENT']


    end

    mount WxApi::WeixinAPI

    # 从根开始截获全部不匹配的 url
    prefix '/'
    # 自定义 根url 返回信息
    get do
       {status: 0}
    end
    # 自定义404 必须要放最后
    route :any, '*path', :anchor => false do
      error!('404: Not Found', 404)
    end
  end
end
