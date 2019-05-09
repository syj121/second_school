module ApplicationHelper

	def link_to_void(*args, &block)
		link_to(*args.insert((block_given? ? 0 : 1), "javascript:void(0)"), &block)
	end

	# 必填项，红星
	def require_span
	  "<span class='red'>* </span>".html_safe
	end

	def link_to_blank(*args, &block)
	  if block_given?
	    options      = args.first || {}
	    html_options = args.second || {}
	    link_to_blank(capture(&block), options, html_options)
	  else
	    name         = args[0]
	    options      = args[1] || {}
	    html_options = args[2] || {}

	    # override
	    html_options.reverse_merge! target: '_blank'

	    link_to(name, options, html_options)
	  end
	end

end
