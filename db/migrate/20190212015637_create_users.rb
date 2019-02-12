class CreateUsers < ActiveRecord::Migration[5.2]
  def change
  	#用户基础信息
    create_table :users do |t|
      t.string :login_name, comment: "登录名"
      t.string :password_digest, comment: "密码"
      t.timestamps
    end
    add_index :users, :login_name, unique: true
  end
end
