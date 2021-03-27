import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("connected ya ray2")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("dona ya 7amdana")
    console.log(data)
      let id = '#notification'+data["userId"];
    console.log(id);
    console.log("howwww")
      if($(id).length) {
        console.log("done");
        $(id).append('<h1 class = "message">' + data.body + '</h1>')
        // Called when there's incoming data on the websocket for this channel
      }

    // Called when there's incoming data on the websocket for this channel
  }
});
