module ApplicationAmazeHelper

	#override 检查权限
	# def link_to(*args, &block)
	# 	super(*args, &block)
	# end

	#dialog link
	def link_to_dialog(*args, &block)
		url = args[0]
		return "" if !check_ability(url)
		args[0] = "javascript:void(0)"
		dialog = args[1][:dialog]
		insert_index = dialog.index("(") + 1
		args[1][:dialog] = dialog.insert(insert_index, "'#{url}',") 
		args[1].store("onclick", args[1][:dialog])
		args[1].delete(:dialog)
		link_to(*args, &block)
	end


	private
	def check_ability(url)
		controller_info = Rails.application.routes.recognize_path(url) #: 获取action,controller
		model_name = controller_info[:controller].split("/").last.classify.constantize
		ac_name = controller_info[:action]
		can?(ac_name.to_sym, model_name)
	end

end