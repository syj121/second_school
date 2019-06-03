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

	def link_to_auth_void(*args, &block)
		if args[0].is_a?(String)
			url = args[0]
			return "" if !check_ability(url)
		else
			url = args[0][:checked_url]
			method_name = args[0][:checked_method] || "GET"
			return "" if !check_ability(url, method_name)
			link_to_void(*args, &block)
		end
	end

	private
	def check_ability(url, method_name="GET")
		controller_info = Rails.application.routes.recognize_path(url, method: method_name) #: 获取action,controller
		model_name = controller_info[:controller].split("/").last.classify.constantize
		ac_name = controller_info[:action]
		can?(ac_name.to_sym, model_name)
	end

end