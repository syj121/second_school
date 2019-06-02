#角色拥有的菜单
class MenuRole < ApplicationRecord

  belongs_to :menu
  belongs_to :role

  before_destroy :check_pundit_group

  #角色菜单删除，则对应的权限全部删除
  def check_pundit_group
  	role.pundit_groups.where(memu_id: self.menu_id).clear
  end
  
end
