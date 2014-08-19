#encoding: utf-8

namespace :weixin do

  def access_token
    'JuwStk7vEpSqH-K3_J7LmOeYvgzHRXgTPdFXOrzszNzKdbvbW4zR-qvH-V18IJNqxyFREAt7mHwY53uGW02tVQ'
  end

  desc '获取微信 access_token'
  task :token => :environment do |t, args|
    appid = 'wxc03cada76c465d33'
    secret = 'bcc611375a39d14a5e61e79b0375a394'
    url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{appid}&secret=#{secret}"

    result = JSON.parse(RestClient.get(url))
    p result
  end



end