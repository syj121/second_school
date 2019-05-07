module Background
	class MenusController < Background::ApplicationPunditController

		before_action :get_menu

		#当前用户的菜单
		def index
			@query = current_user.controllable_menus.ransack(params[:q])
			@menus = @query.result.page(params[:page])
		end

		def new
			@menu = Menu.new
			@menus = current_user.menus.pluck(:system_menu_name, :controller_path)
		end

		def create
			#保存系统权限菜单
			ActiveRecord::Base.transaction do 
				menu = Menu.new(params[:menu].permit!)
				menu.system_menu_name = Pundit.pundit_name(menu.controller_path)
				menu.save!
				current_user.controllable_menus << menu
			end
			redirect_to action: :index
		end

		def show
		end

		def edit
			@menus = current_user.menus.pluck(:system_menu_name, :controller_path)
		end

		def update
			#保存系统权限菜单
			@menu.update(params[:menu].permit!)
			redirect_to action: :index
		end

		def destroy
			@menu.destroy!
			@menus = current_user.controllable_menus.ransack(JSON.parse(params[:q])).result.page(params[:page])
		end

		private
		def get_menu
			if params[:id].present?
				@menu = Menu.find(params[:id])
			end
		end

	end
end