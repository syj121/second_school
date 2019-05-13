module Background
	class RolesController < Background::ApplicationPunditController
	  before_action :set_role

	  # GET /roles
	  # GET /roles.json
	  def index
	  	@query = Role.ransack(params[:q])
	    @roles = @query.result.page(params[:page])
	  end

	  # GET /roles/1
	  # GET /roles/1.json
	  def show
	  end

	  # GET /roles/new
	  def new
	    @role = Role.new
	    render layout: "application_dialog"
	  end

	  # GET /roles/1/edit
	  def edit
	  	render layout: "application_dialog"
	  end

	  # POST /roles
	  # POST /roles.json
	  def create
	    @role = Role.new(role_params)
	    if @role.save
	    	return render json: {success: true, desc: "新增成功"}
	    end
	    render json: {success: false, desc: "新增失败：#{@role.error_msg}"}	
	  end

	  # PATCH/PUT /roles/1
	  # PATCH/PUT /roles/1.json
	  def update
	  	if @role.update(role_params)
	  		return render json: {success: true, desc: "更新成功"}
	  	end
	  	render json: {success: false, desc: "更新失败：#{@role.error_msg}"}	
	  end

	  # DELETE /roles/1
	  # DELETE /roles/1.json
	  def destroy
	    @role.destroy
	    render json: {success: true, desc: "删除成功！"}
	  end

	  #为角色分配菜单
	  def menus
	    @menus = current_user.menus
	    @checked = @role.menus.pluck(:id)
	    render layout: "application_dialog"
	  end

	  #保存菜单
	  def menus_save 
	    ActiveRecord::Base.transaction do 
	    	@role.menu_roles.where.not(menu_id: params[:menus]).delete_all
	    	@role.role_menus.where.not(menu_id: params[:menus]).delete_all
	    	@role.pundit_group_roles.where.not(menu_id: params[:menus]).delete_all

	      current_user.menus.where(id: params[:menus]).each do |menu|
	        MenuRole.find_or_create_by!(menu_id: menu.id, role_id: @role.id)
	        #保存角色管理的菜单
	        RoleMenu.find_or_create_by(menu_id: menu.id, role_id: @role.id)
	      end
	    end
	    render json: {success: true, desc: "设置成功"}
	  end

	  def pundit_groups
	    @menus = @role.menus.map { |menu| 
	      {
	        menu_id: menu.id,
	        menu_name: menu.name,
	        controller_path: menu.controller_path,
	        pundit_groups: current_user.pundit_group_roles.where(menu_id: menu.id).map { |pundit_group|{
	            pundit_group_id: pundit_group.id,
	            pundit_group_name: pundit_group.group_name
	        }} 
	      }
	    }
	    @checked = @role.pundit_group_roles.pluck(:id)  #errors
	    render layout: "application_dialog"
	  end

	  #保存角色的权限组
	  def pundit_groups_save
	    ActiveRecord::Base.transaction do 
	      params[:pundit_groups].each do |menu_id, pundit_group_ids|
	        #保存角色的权限组
	        current_user.pundit_group_roles.where(id: pundit_group_ids).map { |pundit_group|  
	          pgr = PunditGroupRole.find_or_initialize_by(menu_id: menu_id, role_id: @role.id, controller_path: pundit_group.controller_path, group_name: pundit_group.group_name)
	          pgr.action_list = Pundit.pundit_group_items(pundit_group.controller_path, pundit_group.group_name) 
	          pgr.save! if pgr.changed?
	        }
	      end
	    end
	    render json: {success: true, desc: "设置成功"}
	  end

	  private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_role
	      @role = Role.find(params[:id]) if params[:id].present?
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def role_params
	      params.require(:role).permit(:name, :desc)
	    end
	end

end