#自动构建系统权限架构
#获取yaml文件数据:  YAML::load_file "/mnt/f/my_work/my_pundit/config/pundits/menu.yml"
#返回: {"menu"=>{"pundit_name"=>"菜单管理", "pundit_groups"=>{"create"=>{"pundit_name"=>"新增", "pundits"=>"new, create"}}}}

#写入yaml文件数据 File.open( "#{Rails.root}/temp.yml", "w") do |f|
#     f.write({"pundit_name"=>"新增", "pundits"=>"new, create"}.to_yaml)
# end
module Pundit

	#获取所有的菜单名称，即pundits文件夹下，每个文件夹下，每个yml名
	#pundits下子文件夹，即为命名空间
	#返回示例：
	def self.menus(file_path="#{Rails.root}/config/pundits", namespace_name=[])
		menu_a = []
		if File.directory?(file_path)
			Dir.foreach(file_path) do |file|
				#file: 文件夹名，即命名空间
				next if [".", ".."].include?(file) 
				menu_a += Pundit.menus("#{file_path}/#{file}", namespace_name + [file])
			end
		else
			namespace_name.pop
			controller_path =  file_path.gsub("#{Rails.root}/config/pundits", "").gsub(".yml","")
			controller_name = controller_path.gsub("/#{namespace_name.join("/")}/", "")
			menu_yml = YAML::load_file "#{file_path}"
			menu_name = menu_yml[controller_name]["pundit_name"]
			menu_a << {controller_path: controller_path, menu_name: menu_name}
		end
		menu_a
	end

	#获取某个菜单下，所有权限组
	#[{group_name: "create", pundits: "new, create"}]
	def self.pundit_groups(controller_path)
		menu_yml = YAML::load_file "#{Rails.root}/config/pundits/#{controller_path}.yml"
		controller_name = controller_path.split("/").last
		menu_yml[controller_name]["pundit_groups"].map { |key, value|  
			{group_name: key, action_list: value["pundits"]}
		}
	end

	#获取某个权限菜单下，某个权限组的所有权限
	#请求示例：Pundit.pundit_group_items("menus", "create")
	#返回示例："new, create"
	def self.pundit_group_items(controller_path, pundit_group_name)
		menu_yml = YAML::load_file "#{Rails.root}/config/pundits/#{controller_path}.yml"
		controller_name = controller_path.split("/").last
		menu_yml[controller_name]["pundit_groups"][pundit_group_name]["pundits"]
	end

	#获取某个菜单的系统菜单名
	#请求示例：
	#返回示例：
	def self.pundit_name(controller_path)
		menu_yml = YAML::load_file "#{Rails.root}/config/pundits/#{controller_path}.yml"
		controller_name = controller_path.split("/").last
		menu_yml[controller_name]["pundit_name"]
	end

	#获取某个菜单下某个权限名
	#请求示例：Pundit.pundit_group_name("menus", "create")
	#返回示例：“创建”
	def self.group_name(controller_path, pundit_group_name)
		menu_yml = YAML::load_file "#{Rails.root}/config/pundits/#{controller_path}.yml"
		controller_name = controller_path.split("/").last
		menu_yml[controller_name]["pundit_groups"][pundit_group_name]["pundit_name"]
	end

end
