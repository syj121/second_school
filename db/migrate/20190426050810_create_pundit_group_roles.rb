class CreatePunditGroupRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :pundit_groups do |t|
    	t.references :menu,  foreign_key: true, comment: "菜单"
    	t.string :controller_path, comment: "控制器（菜单）路径，例：background/menus "
    	t.string :group_name, comment: "权限组，例： create"
    	t.string :action_list, comment: "权限列表，例：new,create"
      t.timestamps
    end

    create_table :pundit_groups_roles, id: false do |t|
      t.references :role
      t.references :pundit_group
      t.timestamps
    end
  end
end
