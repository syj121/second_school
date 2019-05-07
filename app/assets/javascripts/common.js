$(function(){
	// 表单异步提交
	$("form.ajax_form").submit(function(){
		var this_form = $(this)
		var current_page = parent.$("#current_page")[0]
		$.ajax({
			url: this_form.attr("action"),
			type: this_form.attr("method"),
			dataType: 'json',
			data: this_form.serialize(),
			success: function (data) {
				//异步刷新分页
				if (data.success) {
					current_page.click()
				}
				parent.layer.closeAll()
				parent.layer.msg(data.desc)
			}
		})
		return false
	})
	// 表单异步提交 END
})

//新增数据通用dialog
function new_record(new_url, title){
	layer.open({
		id: "new_record_dialog",
		title: title,
	  type: 2,
	  area: ['700px', '450px'],
	  fixed: false, //不固定
	  maxmin: true,
	  content: new_url
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
	  		if (data.success) {
	  			current_page.click()
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


