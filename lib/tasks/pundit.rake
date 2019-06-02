# encoding: utf-8
# rake init:pundits
namespace :pundit do 

	desc "权限初始化  将权限组，写入yml文件中"
	task :init_yml => :environment do

		#开发环境中，未加载，需要手动加载文件。
		Rails.application.eager_load!
		common_methods = [:index, :new, :create, :edit, :update, :show, :destroy]
		Background::ApplicationPunditController.subclasses.each do |controller|
			controller_name = controller.controller_name
			#检查文件是否存在
			old_yml = YAML::load_file("#{Rails.root}/config/pundits/#{controller.name.underscore.sub("_controller","")}.yml") rescue ""
			pundit_name = old_yml[controller_name]["pundit_name"] rescue controller_name
			#通用增删改查权限
			pundit_groups = {
				"create" => {
					"pundit_name" => "新增",
					"pundits" => "new,create"
				},
				"show" => {
					"pundit_name" => "查看",
					"pundits" => "show,index"
				},
				"edit" => {
					"pundit_name" => "编辑",
					"pundits" => "edit,update"
				},
				"destroy" => {
					"pundit_name" => "删除",
					"pundits" => "destroy"
				}
			}
			#常规权限，例：menus/menus_save； caches/caches_do。名字相近为一组
			regular_pundits = controller.instance_methods(false) - common_methods
			regular_pundits.group_by{|r|r.to_s.split("_").first}.each do |pname, groups|
				pundit_groups[pname] ||= {}
				pundit_group_name = (old_yml[controller_name]["pundit_groups"][pname]["pundit_name"] rescue nil) || pname
				pundit_groups[pname] = {
					"pundit_name" => pundit_group_name,
					"pundits" => groups.map(&:to_s).join(",")
				}
			end
			#end
						
			File.open( "#{Rails.root}/config/pundits/background/#{controller_name}.yml", "w") do |f|
			     f.write({controller_name => {
			     	"pundit_name" => pundit_name,
			     	"pundit_groups" => pundit_groups
			     }}.to_yaml)
			end
		end
	end


	desc "权限初始化  将权限组，写入sql文件中"
	task :init_sql => :environment do
		#初始化数据库超级管理员权限
		ActiveRecord::Base.transaction do 
			#初始化角色表
			role = Role.find_or_create_by!(name: "超级管理员", desc: "超级管理员", category_type: "admin", id: 1)
			#初始化用户表
			user = User.find_or_initialize_by(login_name: "super_admin", current_role_id: 1, id: 1)
			user.password = "12345678"
			user.password_confirmation = "12345678"
			user.save!
			#初始化菜单、权限
			Pundit.menus.map { |menu| 
				controller_path = menu[:controller_path]
				menu_name = menu[:menu_name]
				#新增菜单
				menu = Menu.find_or_create_by!(name: menu_name, system_menu_name: menu_name, controller_path: controller_path)
				#菜单角色关联
				MenuRole.find_or_create_by!(menu_id: menu.id, role_id: 1)
				#系统菜单，权限组
				Pundit.pundit_groups(controller_path).map { |pundit_group| 
					#角色权限组
					pg = PunditGroup.find_or_create_by!(menu_id: menu.id, controller_path: controller_path, group_name: pundit_group[:group_name], action_list: pundit_group[:action_list])
					role.pundit_groups << pg
				}
			}
			#用户角色表
			RoleUser.find_or_create_by!(role_id: 1, user_id: 1)
		end
	end

end