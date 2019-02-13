class User < ApplicationRecord
	#include/require
	include MySecurePassword
	#配置
	has_secure_password :pay_password
	has_secure_password :password
	#验证
	validates :login_name, :presence => true, :uniqueness => true
	validates :password, presence: true, length: { minimum: 6, maximun: 16 }
	#查询
	#回调

	#实例方法
	def method_name
	end

	#类方法  

end
