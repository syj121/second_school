class Menu < ApplicationRecord

	has_many :menu_roles, dependent: :destroy
	has_many :roles, through: :menu_roles

	has_many :role_menus, dependent: :destroy

end
