#encoding: utf-8
namespace :code do

  desc '生成5000个a码'
  task :g => :environment do |t, args|
    count = Code.where(level: Code.levels[:a_price]).count
    if count < 5000
      (5000 - count).times do
        Code.new_code(:a_price)
      end
    end
  end


end