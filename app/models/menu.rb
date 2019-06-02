class Menu < ApplicationRecord

	has_many :menu_roles, dependent: :destroy
	has_many :roles, through: :menu_roles

	scope :show_menu, -> {where(menu_type: 1)}

	MENU_TYPE = { 1 => "可显示菜单", 2 => "隐藏菜单"}

end
