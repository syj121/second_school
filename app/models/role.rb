class Role < ApplicationRecord

	#菜单
	has_many :menu_roles, dependent: :destroy
	has_many :menus, through: :menu_roles
	#权限组
	has_and_belongs_to_many :pundit_groups

	CATEGORY_TYPE = {admin: "管理员角色", common: "普通角色"}
end
