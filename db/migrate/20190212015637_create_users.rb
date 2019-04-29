class CreateUsers < ActiveRecord::Migration[5.2]
  def change
  	#用户基础信息
    create_table :users do |t|
      t.string :login_name, unique: true,comment: "登录名"
      t.string :real_name, comment: "真实姓名"
      t.string :password_digest, comment: "密码"
      t.integer :current_role_id, comment: "当前角色ID"
      t.timestamps
    end
  end
end
