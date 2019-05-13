class AuthsController < ApplicationController

	layout "auths"

	#登录
	def sign_in
		render "sign_in_amaze"
	end

	#验证、保存登录信息
	def do_sign_in
		user = User.find_by(login_name: params[:login_name]) 
		if user.blank? 
			flash[:error] = "没有找到该用户"
			redirect_to action: :sign_in
		elsif (flag = user.authenticate_password(params[:password])) && user.roles.exists?(id: params[:role_id])
			session[:current_user] = {login_name: params[:login_name]} 
			user.update(current_role_id: params[:role_id])
			flash[:success] = "登录成功"
			redirect_to background_users_path
		elsif flag
			return render_error_page(401)
		else
			flash[:error] = "密码错误"
			redirect_to action: :sign_in
		end
	end

	#注册
	def sign_up
	end

	#保存注册信息
	def do_sign_up
	end

	def sign_out
		session.delete :current_user
		flash[:success] = "登出成功"
		redirect_to action: :sign_in
	end

end