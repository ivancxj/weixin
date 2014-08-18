#encoding: utf-8

namespace :weixin do

  def access_token
    ''
  end

  desc '获取微信 access_token'
  task :token => :environment do |t, args|
    appid = '111'
    secret = '123'
    url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{appid}&secret=#{secret}"

    result = JSON.parse(RestClient.get(url))
    p result
  end



end