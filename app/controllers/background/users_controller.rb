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
		@user = User.new(user_params)
		if @user.save
			return render json: {success: true, desc: "新增成功"}
		end
		render json: {success: false, desc: "新增失败：#{@user.error_msg}"}	
	end

	def edit
		render layout: "application_dialog"
	end

	def update
		if @user.update(user_params)
			return render json: {success: true, desc: "更新成功"}
		end
		render json: {success: false, desc: "更新失败：#{@user.error_msg}"}		
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