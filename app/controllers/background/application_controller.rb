module Background

	class ApplicationController < ::ApplicationController

		before_action :check_login
		helper_method :current_menu

		#当前菜单权限
		def current_menu
			@current_menu ||= current_user.menus.find_by(controller_path: "/#{controller_path}")
		end

		private
		def check_login
			if session[:current_user].blank?
				return redirect_to sign_in_auth_path
			end
		end

	end

end
