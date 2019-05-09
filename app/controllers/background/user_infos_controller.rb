class Background::UserInfosController < Background::ApplicationPunditController

	def edit
	end

	def update 
		if current_user.update(user_params)
			return redirect_to root_path
		end
		redirect_to :back
	end

	def show
	end

	private
	def user_params
		params.require(:user).permit(:login_name, :real_name, :role_ids, :password, :password_confirmation, head_portraits_attributes: [:id, :image_type, :image_url, :_destroy])
	end

end