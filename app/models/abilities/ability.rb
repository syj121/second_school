# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    #管理员操作所有项
  	if user.current_role_id == 1
  		can :manage, :all
    else
      #当前用户，根据当前角色，操作部分内容
      user.current_role.pundit_groups.pluck(:controller_path, :action_list).each do |pundit_groups|
        mode_name = pundit_groups[0].split("/").last.classify.constantize
        pundit_groups[1].split(",").each do |aname|
          can aname.to_sym, mode_name
        end
      end
  	end
  end

end
