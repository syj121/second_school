class Role < ApplicationRecord

	#菜单
	has_many :menu_roles
	has_many :menus, through: :menu_roles
	#权限组
	has_and_belongs_to_many :pundit_groups
end
