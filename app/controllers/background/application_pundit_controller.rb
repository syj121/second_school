module Background
	class ApplicationPunditController < ApplicationController

		before_action :check_login
		before_action :check_pundit

		helper_method :current_menu, :current_pundit_actions

		private
		def check_login
			if session[:current_user].blank?
				return redirect_to sign_in_auth_path
			end
			if current_user.current_role_id.blank?
				return render_error_page(422)
			end
		end

		#检查是否有操作权限
		def check_pundit
			# if current_menu.blank?
			# 	return render_error_page(401)
			# end
			# if current_pundit_actions.exclude?(action_name)
			# 	return render_error_page(401)
			# end
		end

		#当前菜单权限
		def current_menu
			@current_menu ||= current_user.menus.find_by(controller_path: "/#{controller_path}")
		end

		def current_pundit_actions
			@current_pundit_actions ||=  current_user.pundit_group_roles.where(menu_id: @current_menu.id).pluck(:action_list).map{|a|a.split(",")}.flatten
		end

	end
end