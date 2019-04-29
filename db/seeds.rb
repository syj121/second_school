# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#初始化超级管理员权限、菜单
ActiveRecord::Base.transaction do 
	#初始化角色表
	Role.find_or_create_by!(name: "超级管理员", desc: "超级管理员", category_type: "admin", id: 1)
	#初始化用户表
	user = User.find_or_initialize_by(login_name: "super_admin", current_role_id: 1, id: 1)
	user.password = "12345678"
	user.password_confirmation = "12345678"
	user.save!
	#初始化菜单、权限
	Pundit.menus.map { |menu| 
		controller_path = menu[:controller_path]
		menu_name = menu[:menu_name]
		#新增菜单
		menu = Menu.find_or_create_by!(name: menu_name, system_menu_name: menu_name, controller_path: controller_path)
		#菜单角色关联
		MenuRole.find_or_create_by!(menu_id: menu.id, role_id: 1)
		#系统菜单，权限组
		Pundit.pundit_groups(controller_path).map { |pundit_group| 
			#角色权限组
			PunditGroupRole.find_or_create_by!(menu_id: menu.id, controller_path: controller_path, group_name: pundit_group[:group_name] , role_id: 1, action_list: pundit_group[:action_list])
		}
		#角色可管理的菜单
		RoleMenu.find_or_create_by(menu_id: menu.id, role_id: 1)
	}
	#用户角色表
	RoleUser.find_or_create_by!(role_id: 1, user_id: 1)
end
