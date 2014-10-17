#encoding: utf-8
class Code < ActiveRecord::Base
  # belongs_to :user
  #********全部字段
  # :level, default: 0
  # :level_at, comment: '用户绑定码时间'
  # :share_at, comment: '分享时间'
  # :code, null: false
  # :parent_id
  # :status,     default: 0
  #********全部字段

  enum level: %w(default a_price b_price c_price)
  enum status: %w(enabled disable used)

  validates_presence_of   :code
  validates_uniqueness_of :code

  def self.random_code
    charset = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z)
    (0...8).map { charset[rand(charset.size)] }.join
  end

  def self.new_code(level, parent_id = nil)
    code = Code.new
    while true
      begin
        code.code = Code.random_code
        code.level = Code.levels[level]
        code.parent_id = parent_id if parent_id.present?
        code.save!

        p code.code
        break
      rescue
        p '有重复'
      end
    end

    code

  end

  def new_next_code

    count = Code.where(parent_id: self.id).count
    return if count >= 10

    if self.a_price?
      level = :b_price
    elsif self.b_price?
      level = :c_price
    else
      # 如果是c码 则没有更低一级邀请码
      return
    end

    (10 - count).times do
      Code.new_code(level, self.id)
    end
  end

  # Callbacks
  before_save do

  end

  before_destroy do

  end


end