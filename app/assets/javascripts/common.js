$(function(){
	//select2初始化
	$(".select2").select2()

	// 新增表单 异步提交
	$("form.ajax_common_form").submit(function(){
		var this_form = $(this)
		var current_page = parent.$("#current_page")[0]
		$.ajax({
			url: this_form.attr("action"),
			type: this_form.attr("method"),
			dataType: 'json',
			data: this_form.serialize(),
			success: function (data) {
				//异步刷新分页
				if (data.success && current_page != undefined) {
					current_page.click()
				}else if (data.success && current_page == undefined) {
					parent.location.reload()
				}
				parent.layer.msg(data.desc)
				if (data.success) {
					parent.layer.closeAll()
				}
			},
			error: function(data) {
				layer.msg("系统异常，请稍后再试")
			}
		})
		return false
	})
	// 新增表单 异步提交 END
})

//新增数据通用dialog
function common_dialog(url, title){
	layer.open({
		id: "common_dialog",
		title: title,
	  type: 2,
	  area: ['700px', '450px'],
	  maxmin: true,
	  content: url
	});
}
//新增数据通用dialog END

//删除数据通用dialog 
function destroy_record(delete_url){
	var current_page = parent.$("#current_page")[0]
	layer.confirm('确认要删除吗？', {
	  btn: ['删除','取消'] //按钮
	}, function(){
	  $.ajax({
	  	type: "delete",
	  	url: delete_url,
	  	success: function(data){
	  		layer.msg(data.desc)
	  		if (data.success && current_page != undefined) {
	  			current_page.click()
	  		}else if (data.success && current_page == undefined) {
	  			parent.location.reload()
	  		}
	  	},
	  	error: function(){
	  		layer.msg("删除失败")
	  	}
	  })
	}, function(){
	});
}
// 删除数据通用dialog END
// 
// 关闭layer_dialog
function cancel_dialog(){
	parent.layer.closeAll()
}
// 关闭layer_dialog END


