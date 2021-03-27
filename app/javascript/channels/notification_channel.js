import consumer from "./consumer";

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("connected ya ray2");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data);
    let id = "#notification" + data["userId"];
    console.log(id);
    if (data["header"] == "validate email") {
      if (data["body"] == "valid") {
        let errorid = "#orderFriendsErrors" + data["userId"];
        if ($(errorid).length) {
          $(errorid).empty();
        }

        let friendsToAdd = "#friendsToAdd" + data["userId"];
        if ($(friendsToAdd).val().indexOf(data.email) == -1) {
          console.log("adding here");
          $(friendsToAdd).val($(friendsToAdd).val() + data.email + " ");

          let id = "#orderFriends" + data["userId"];
          if ($(id).length) {
            console.log("done");
            $(id).append(`<div id=member${data.friend[0].friend_id}><h1 class = "message">${data.email}</h1><label  onclick="deleteItem(${"member"+data.friend[0].friend_id},${friendsToAdd.replace("#","")})">click me</label></div>`);
          }
        } else {
          errorMsg("you cant add the same member twice", data);
        }
      } else {
        errorMsg(data.body, data);
      }
    } else {
      if ($(id).length) {
        console.log("done");
        $(id).append('<h1 class = "message">' + data.body + "</h1>");
        // Called when there's incoming data on the websocket for this channel
      }
    }

    // Called when there's incoming data on the websocket for this channel
  },
});
function errorMsg(msg, data) {
  let id = "#orderFriendsErrors" + data["userId"];
  if ($(id).length) {
    console.log("done");
    $(id).empty();
    $(id).append('<h1 class = "message">' + msg + "</h1>");
  }
}

