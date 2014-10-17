# -*- encoding : utf-8 -*-
class WeixinsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # before_filter :check_weixin_legality

  def access_token
    '5Ahdp-AoTh1cktq5RJT9ynmK8aPjIBbaypIotIAFq3xJ6IRE1bI-0kmmlojqb96KK5ZLl56nSBHrhnHLdjCb4w'
  end
  def appid
    'wx024d24cb82e4ffed'
  end
  def secret
    'df70ff311a69a88fa5ca0f3d7d635958'
  end


  # GET /weixin
  def show
    render :text => params[:echostr]
  end

  # POST /weixin
  def create
    p params
    p params[:xml]
    p xml_params
    url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx024d24cb82e4ffed&redirect_uri=http://636dc7d1.ngrok.com/weixin/oauth&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"

    # if params[:xml][:MsgType] == "text"
    #   render 'echo', :formats => :xml
    # end
    render 'echo', :formats => :xml
  end


  # GET /weixin/welcome
  # 欢迎信息
  def welcome
    render :text => '欢迎登陆'
  end

  # GET /weixin/oauth
  # 欢迎信息
  def oauth
    render :text => params[:code]
  end


  private
  def check_weixin_legality
    array = ['cxj', params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

  def xml_params
    params.require(:xml).permit!
  end

end
