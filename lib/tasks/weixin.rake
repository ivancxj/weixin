#encoding: utf-8

namespace :weixin do

  def access_token
    '5Ahdp-AoTh1cktq5RJT9yhw88-sGyBdn0ejYKFi4jK9aHknoMsvDYoUUVbrHF004pWeihbnbhEVUIVM9KEsb8Q'
  end

  def appid
    'wx024d24cb82e4ffed'
  end

  def secret
    'df70ff311a69a88fa5ca0f3d7d635958'
  end

  desc '获取微信 access_token'
  task :token => :environment do |t, args|
    url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{appid}&secret=#{secret}"

    result = JSON.parse(RestClient.get(url))
    p result
  end

  desc '自定义菜单'
  task :menu_create => :environment do |t, args|

    url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=#{access_token}"

    redirect_uri = 'http://6154d946.ngrok.com/weixin/oauth'
    u = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx024d24cb82e4ffed&redirect_uri=#{redirect_uri}&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect"
    # u = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{appid}&redirect_uri=REDIRECT_URI&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect"

    menu = {button: [
          {type: 'view', name: '今日歌曲', url: u.html_safe},
          {type: 'click', name: '歌手简介', key: 'V1001_TODAY_SINGER'},
          {name: '菜单', sub_button: [
               {type: 'view', name: '搜索', url: 'http://www.baidu.com'},
               {type: 'view', name: '视频', url: 'http://www.baidu.com'}
          ]}

    ]
    }

    p menu.to_json

    result = JSON.parse(RestClient.post(url,menu.to_json))
    p result
  end

  # "code"=>"002c40c3b413100ecc74b3ca02dba182"
  desc '使用code换取access_token'
  task :get_token => :environment do |t, args|

    url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{appid}&secret=#{secret}&code=02a48ab97d2ac6d367f8afd5f76151b8&grant_type=authorization_code"


    result = JSON.parse(RestClient.get url)
    p result
  end


  desc '使用access_token获取用户信息'
  task :userinfo => :environment do |t, args|
    access_token = "OezXcEiiBSKSxW0eoylIeJ7sAqJBKjVutt7kNwSt9QgifGzbKeyIQQTuV5HU93rivfSL4480WAAZlWFYkicjiAT2QQpG4RiiM-p_FwQbCAqMydhWmv6Rj8D5uPIB6eYrKcw4fRKeLOo2qSSosT8IvQ"
    openid = "oVi3Us35P9NOhDO0itNKERA8AXmI"
    url = "https://api.weixin.qq.com/sns/userinfo?access_token=#{access_token}&openid=#{openid}"


    result = JSON.parse(RestClient.get url)
    p result
  end


end