module ApplicationHelper

	def link_to_void(*args, &block)
		link_to(*args.insert((block_given? ? 0 : 1), "javascript:void(0)"), &block)
	end

	# 必填项，红星
	def require_span
	  "<span class='red'>* </span>".html_safe
	end

end
