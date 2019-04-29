class User < ApplicationRecord

	#关联
	#用户当前角色
	belongs_to :current_role, class_name: "Role", foreign_key: "current_role_id", optional: true
	#代理
	delegate :pundit_group_roles, :menus, :controllable_menus, :to => :current_role, allow_nil: true
	#用户菜单
	has_many :menu_users
	has_many :menus, through: :menu_users
	#角色
	has_many :role_users
	has_many :roles, through: :role_users

	#include/require
	include MySecurePassword
	#配置
	has_secure_password :password
	#has_secure_password :pay_password
	#验证
	validates :login_name, :presence => true, :uniqueness => true
	validates :password, presence: true, length: { minimum: 6, maximun: 16 }, confirmation: true, unless: Proc.new { |a| a.password.blank? }
	#回调

	#实例方法
	def method_name
	end

	#类方法  

end
