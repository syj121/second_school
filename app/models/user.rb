class User < ApplicationRecord

	#include/require
	include MySecurePassword

	#关联
	#用户当前角色
	belongs_to :current_role, class_name: "Role", foreign_key: "current_role_id", optional: true
	#代理
	delegate :pundit_groups, :menus, :to => :current_role, allow_nil: true
	#用户菜单
	has_many :menu_users
	has_many :menus, through: :menu_users
	#角色
	has_many :role_users
	has_many :roles, through: :role_users
	#头像
	has_many :head_portraits, -> {where(image_type: "head_portrait")}, class_name: "UserImage", foreign_key: "user_id"
	accepts_nested_attributes_for :head_portraits, :reject_if => lambda { |item| item[:image_url].blank? }, :allow_destroy => true
	#配置
	has_secure_password :password
	#has_secure_password :pay_password
	#验证
	validates :login_name, :presence => true, :uniqueness => true
	validates :password, presence: true, length: { minimum: 6, maximun: 16 }, confirmation: true, unless: Proc.new { |a| a.password.blank? }
	#回调
	after_create :check_head_protraits

	#如果没有头像，默认头像
	def check_head_protraits
		if head_portraits.blank?
			pic = self.head_portraits.new
			pic.image_url = File.open("#{Rails.root}/vendor/assets/images/amaze/user06.png")
			pic.save!
		end
	end

end
