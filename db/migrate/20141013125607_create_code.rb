class CreateCode < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      # t.references  :user

      t.integer   :level, default: 0
      t.datetime  :level_at, comment: '用户绑定码时间'
      t.datetime  :share_at, comment: '分享时间'
      t.string    :code, null: false
      t.integer   :parent_id
      t.integer   :status,     default: 0

      t.timestamps
    end

    # add_index :codes, :user_id
    add_index :codes, :code,                unique: true
  end
end
