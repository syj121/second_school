
# 客户端通过 App.cable = ActionCable.createConsumer("ws://cable.example.com")（位于 cable.js 文件中）连接到服务器。服务器通过 current_user 标识此连接。
# 客户端通过 App.cable.subscriptions.create(channel: "AppearanceChannel")（位于 appearance.coffee 文件中）订阅在线状态频道。
# 服务器发现在线状态频道创建了一个新订阅，于是调用 subscribed 回调方法，也即在 current_user 对象上调用 appear 方法。
# 客户端发现订阅创建成功，于是调用 connected 方法（位于 appearance.coffee 文件中），也即依次调用 @install 和 @appear。@appear 会调用服务器上的 AppearanceChannel#appear(data) 方法，同时提供 { appearing_on: $("main").data("appearing-on") } 数据散列。之所以能够这样做，是因为服务器端的频道实例会自动暴露类上声明的所有公共方法（回调除外），从而使远程过程能够通过订阅的 perform 方法调用它们。
# 服务器接收向在线状态频道的 appear 动作发起的请求，此频道基于连接创建，连接由 current_user（位于 appearance_channel.rb 文件中）标识。服务器通过 :appearing_on 键从数据散列中检索数据，将其设置为 :on 键的值并传递给 current_user.appear。


class UserChannel < ApplicationCable::Channel
	#当客户端连接上来的时候使用的方法, 当用户成为此频道的订阅者时调用
  def subscribed
  	#接收来自user_channel频道的流数据， 将广播发送给订阅者
    stream_from "user_channel"
  end

  #当客户端与服务器失去连接的时候使用的方法
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	#发送广播
  	ActionCable.server.broadcast "user_channel", content: data["content"]
  end
end
