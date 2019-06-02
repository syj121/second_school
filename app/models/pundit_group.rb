class PunditGroup < ApplicationRecord

	belongs_to :menu
	has_and_belongs_to_many :role

	# after_create :redis_set
	# after_destroy :redis_delete

	# #权限缓存到redis中
	# def redis_set
	# 	#角色该菜单下的权限
	# 	pundit_groups = $redis.get("role_pundit_groups_#{role_id}_#{menu_id}") || ""
	# 	#添加该菜单下的权限
	# 	pundit_groups = [pundit_groups.split(",") + self.action_list.split(",")].uniq
	# 	#保存角色菜单权限
	# 	$redis.set("role_pundit_groups_#{role_id}_#{menu_id}", pundit_groups.join(","))
	# end

	# #将权限从redis清除
	# def redis_delete
	# 	$redis.del("role_pundit_groups_#{role_id}_#{menu_id}")
	# end

end
