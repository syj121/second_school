# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
  	if user.current_role_id == 1
  		can :manage, :all
  	else
  		#当前用户角色权限
  		PunditGroupRole.where(controller_path: "/background/menus", role_id: user.current_role_id).pluck(:action_list).each do |action_list|
  			action_list.split(",").each do |aname|
  				can aname.to_sym, Menu
  			end
  		end
  	end
  end

end
