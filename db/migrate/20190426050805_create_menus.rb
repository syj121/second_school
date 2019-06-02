class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :name, comment: "菜单名"
      t.string :controller_path, comment: "系统菜单路径"
      t.string :system_menu_name, comment: "系统菜单名"
      t.string :description, comment: "菜单简述"
      t.integer :menu_type, default: 1, comment: "菜单类别： 1 左侧显示菜单  2 隐藏菜单"
      t.timestamps
    end
  end
end
