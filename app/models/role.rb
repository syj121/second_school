class Role < ApplicationRecord

	#菜单
	has_many :menu_roles
	has_many :menus, through: :menu_roles
	#权限组
	has_many :pundit_group_roles
	#可管理的菜单
	has_many :role_menus
	has_many :controllable_menus, through: :role_menus, source: "menu"
end
