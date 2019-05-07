class Background::UsersController < Background::ApplicationPunditController

	before_action :get_user

	def index
		@query = User.ransack(params[:q])
		@users = @query.result.page(params[:page])
	end

	def new
		@user = User.new
		render layout: "application_dialog"
	end

	def create
		@user = User.create(params[:user].permit!)
		message = @user.new_record? ? @user.error_msg : "新增成功"
		render json: {success: true, desc: message}
	end

	def edit
		render layout: "application_dialog"
	end

	def update
		@update_flag = @user.update(user_params)
	end

	def show
	end

	def destroy
		@user.destroy
		render json: {success: true, desc: "删除成功！"}
	end

	private
	def get_user
		@user = User.find(params[:id]) if params[:id].present?
	end

	def user_params
		params.require(:user).permit(:login_name, :real_name, :role_ids)
	end

end