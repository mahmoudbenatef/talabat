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
    if (data["header"] == "validate email") {
      if (data["body"] == "valid") {
        let errorid = "#orderFriendsErrors" + data["userId"];
        if ($(errorid).length) {
          $(errorid).empty();
        }

        let friendsToAdd = "#friendsToAdd" + data["userId"];
        if ($(friendsToAdd).val().indexOf(data.email) == -1) {
          $(friendsToAdd).val($(friendsToAdd).val() + data.email + " ");

          let id = "#orderFriends" + data["userId"];
          if ($(id).length) {
            let user = {
              id :data.friend[0]["friend_id"],
              email : data.email
            }
            let clickId= `member${data.friend[0].friend_id}click`
                let addedElement = `<div id=member${data.friend[0].friend_id}><h1 class = "message">${data.email}</h1><span userId = ${data["userId"]} email = ${data["email"]}    id=${clickId}> click me</span></div>`
            $(id).append(addedElement);
            $(id).on("click",`div > ${"#"+clickId}`, (e)=>{
              let hiddenInput = $("#friendsToAdd"+$("#"+ e.target.id).attr("userid"))
              let deletedEmail = $("#"+ e.target.id).attr("email")
              $("#"+ e.target.id).closest("div").fadeOut().remove();
              $(hiddenInput).val($(hiddenInput).val().replace(deletedEmail ,""))
              console.log( $(hiddenInput).val() )
            })
          }
        } else {
          errorMsg("you cant add the same member twice", data);
        }
      } else {
        errorMsg(data.body, data);
      }
    } else {
      if ($(id).length) {
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
    $(id).empty();
    $(id).append('<h1 class = "message">' + msg + "</h1>");
  }
}

