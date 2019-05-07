(function() {
	//订阅在线状态频道
	App.room = App.cable.subscriptions.create("UserChannel", {
		connected: function(){
			console.log("已连接")
		},
		disconnected: function(){
			console.log("已掉线")
		},
		received: function(data){
			debugger
			$("#speak").html(data["content"])
		},
		speak: function(data){  //前台js调用
			return this.perform("speak", {content: data})
		}
	})
}).call(this);
