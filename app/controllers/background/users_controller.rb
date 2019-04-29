class Background::UsersController < Background::ApplicationPunditController

	before_action :get_user

	def index
		@query = User.ransack(params[:q])
		@users = @query.result.page(params[:page])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(params[:user].permit!)
		redirect_to action: :index, notice: @user.error_msg
	end

	def edit
	end

	def update
		@user.update(user_params)
		redirect_to action: :index
	end

	def show
	end

	def destroy
		@user.destroy
		redirect_to action: :index
	end

	alias_method :search, :index

	private
	def get_user
		@user = User.find(params[:id]) if params[:id].present?
	end

	def user_params
		params.require(:user).permit(:login_name, :real_name, :role_ids)
	end

end