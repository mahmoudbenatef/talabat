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
    console.log(data)
      let id = '#notification'+data["userId"];
    console.log(id);
    if(data["header"] ==  "validate email")
    {
      if(data["body"] == "valid")
      {
        let errorid = "#orderFriendsErrors"+data["userId"]
        if($(errorid).length) {
          $(errorid).empty()
        }

        let friendsToAdd = "#friendsToAdd"+data["userId"]
        $(friendsToAdd).val($(friendsToAdd).val() + data.email + " ")

        let id = "#orderFriends"+data["userId"]
        if($(id).length) {
          console.log("done");
          $(id).append('<h1 class = "message">' + data.email + '</h1>')
        }

      }
      else {
        let id = "#orderFriendsErrors"+data["userId"]
        if($(id).length) {
          console.log("done");
          $(id).empty()
          $(id).append('<h1 class = "message">' + data.body + '</h1>')
        }

      }
    }else if(data["header"] ==  "new item"){

      // id="order<%=@order.id%>user<%=current_user.id%>"


      console.log("done");
      console.log(data["users"]);
      let ids =  data["users"].map(user => "#order"+data["order_id"]+"user"+user);

      ids.map(user => {
        if($(user).length) {
          $(user).append('<tr><td>' + data["orderItem"].name + '</td><td>' + data["orderItem"].item_name + '</td><td>' + data["orderItem"].amount + '</td><td>' + data["orderItem"].price + '</td><td>' + data["orderItem"].comment + '</td></tr>')
          // Called when there's incoming data on the websocket for this channel
        }
      });
    }
      else {
      if($(id).length) {
        console.log("done");
        $(id).append('<h1 class = "message">' + data.body + '</h1>')
        // Called when there's incoming data on the websocket for this channel
      }
    }

    // Called when there's incoming data on the websocket for this channel
  }
});
