module Background
	class RolesController < Background::ApplicationPunditController

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
	    render layout: "application_dialog"
	  end

	  # GET /roles/1/edit
	  def edit
	  	render layout: "application_dialog"
	  end

	  # POST /roles
	  # POST /roles.json
	  def create
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
	    	@role.menu_ids = params[:menu_ids]
	    end
	    render json: {success: true, desc: "设置成功"}
	  end

	  #为角色分配权限
	  def pundit_groups
	    @menus = @role.menus.map { |menu| 
	      {
	        menu_id: menu.id,
	        menu_name: menu.name,
	        controller_path: menu.controller_path,
	        pundit_groups: current_user.pundit_groups.where(menu_id: menu.id).map { |pundit_group|{
	            pundit_group_id: pundit_group.id,
	            pundit_group_name: pundit_group.group_name
	        }} 
	      }
	    }
	    @checked = @role.pundit_groups.pluck(:id)
	    render layout: "application_dialog"
	  end

	  #保存角色的权限组
	  def pundit_groups_save
	    ActiveRecord::Base.transaction do 
	    	@role.pundit_group_ids = current_user.pundit_groups.where(id: params[:pundit_group_ids]).pluck(:id)
	    end
	    render json: {success: true, desc: "设置成功"}
	  end

	  private
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def role_params
	      params.require(:role).permit(:name, :desc, :category_type)
	    end
	end

end