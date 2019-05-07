// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  //连接到服务器。服务器通过 current_user 标识此连接。
  App.cable = ActionCable.createConsumer();

}).call(this);
