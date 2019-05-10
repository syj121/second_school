class ApplicationController < ActionController::Base

	before_action :init_params

	helper_method :current_user

	def init_params
		params[:q] ||= {}
	end

	def current_user
		@current_user ||= User.find_by(login_name: session[:current_user][:login_name])
	end

	def render_error_page(error_type)
		return redirect_to "/#{error_type}.html"
	end

end
