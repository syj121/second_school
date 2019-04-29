class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name, comment: "角色名"
      t.string :desc, comment: "描述"
      t.string :category_type, comment: "角色分类：采购人、管理员"
      t.timestamps
    end
  end
end
