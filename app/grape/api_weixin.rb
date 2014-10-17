#encoding: utf-8
module WxApi
  class WeixinAPI < Grape::API
    # version 'v1', :using => :path
    format :xml
    content_type :xml, "text/xml"

    helpers do
      def check

        signature = params[:signature]
        timestamp = params[:timestamp]
        nonce = params[:nonce]
        token = 'cxj'
        array = [token, timestamp, nonce].sort
        error!({ error: '403 Forbidden' }, 403) if signature != Digest::SHA1.hexdigest(array.join)

      end
    end

    resource :weixin do
      desc '微信回调认证'
      params do
        requires :signature, desc: '微信加密签名，signature结合了开发者填写的token参数和请求中的timestamp参数、nonce参数。'
        requires :timestamp, desc: '时间'
        requires :nonce, desc: '随机数'
        requires :echostr, desc: '随机字符串'
      end
      get do
        check
        params[:signature]
      end

      desc '认证'
      get :oauth do
        puts params[:code]
        # body = Hash.from_xml(request.body.read)
        params[:code]
      end

      desc '回复'

      post do
        body = Hash.from_xml(request.body.read)
        puts body

        status("200")
        case body['xml']['MsgType']
          when "text"
            reply = body['xml']['Content']
          when "event"
            reply = body['xml']['Content']
          when "location"
            url = "http://api.map.baidu.com/geocoder?location=#{body['xml']['Location_X']},#{body['xml']['Location_Y']}&output=json&key=9d303595cfbaa7f96ab0e7f56c1fd29f"
            result = JSON::parse(Net::HTTP.get(URI(url)))
            reply = result["result"]["formatted_address"]
        end
        builder = Nokogiri::XML::Builder.new do |x|
          x.xml() {
            x.ToUserName {
              x.cdata body['xml']['FromUserName']
            }
            x.FromUserName {
              x.cdata body['xml']['ToUserName']
            }
            x.CreateTime Time.now.to_i.to_s
            x.MsgType {
              x.cdata "text"
            }
            # x.Url {
            #   x.cdata "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx024d24cb82e4ffed&redirect_uri=http://636dc7d1.ngrok.com/weixin/oauth&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"
            # }
            x.Content {
              x.cdata "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx024d24cb82e4ffed&redirect_uri=http://636dc7d1.ngrok.com/weixin/oauth&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect"
            }
            # x.Title {
            #   x.cdata '挑剔'
            # }
            # x.Description {
            #   x.cdata '描述'
            # }
            x.MsgId body['xml']['MsgId']
            x.FuncFlag("0")
          }
        end


      end
    end
  end
end



