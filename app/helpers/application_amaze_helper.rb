module ApplicationAmazeHelper

	#override 检查权限
	# def link_to(*args, &block)
	# 	super(*args, &block)
	# end

	#dialog link
	def link_to_dialog(*args, &block)
		url = args[0]
		#Rails.application.routes.recognize_path(url) : 获取action,controller
		args[0] = "javascript:void(0)"
		dialog = args[1][:dialog]
		insert_index = dialog.index("(") + 1
		args[1][:dialog] = dialog.insert(insert_index, "'#{url}',") 
		args[1].store("onclick", args[1][:dialog])
		args[1].delete(:dialog)
		link_to(*args, &block)
	end

end