class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :name, comment: "菜单名"
      t.string :controller_path, comment: "系统菜单路径"
      t.string :system_menu_name, comment: "系统菜单名"
      t.string :description, comment: "菜单简述"
      t.timestamps
    end
  end
end
