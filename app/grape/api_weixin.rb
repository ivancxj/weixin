#encoding: utf-8
module WxApi
  class WeixinAPI < Grape::API
    version 'v1'

    resource :weixin do
      desc '微信回调认证'
      params do
        requires :signature,   desc:'微信加密签名，signature结合了开发者填写的token参数和请求中的timestamp参数、nonce参数。'
        requires :timestamp,   desc:'时间'
        requires :nonce,       desc:'随机数'
        requires :echostr,     desc:'随机字符串'
      end
      get do
        signature = params[:signature]
        timestamp = params[:timestamp]
        nonce = params[:nonce]
        token = 'guangjieba'

        array = [token, timestamp, nonce].sort
        error!({ error: '403 Forbidden' }, 403) if signature != Digest::SHA1.hexdigest(array.join)

        signature

      end
    end
  end
end



