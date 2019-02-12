module ActiveRecordExtend

	extend ActiveSupport::Concern

	#定制错误信息
	def error_msg(split_character="；")
		errors.messages.values.map{|e|e[0]}.join(split_character)
	end

end