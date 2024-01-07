import consumer from "../channels/action_cable";

document.addEventListener('turbo:load', function() {
  
  const chats = document.getElementById('chats');

  if (chats) {
    let chatRoomId = chats.dataset.id;

  const appRoom = consumer.subscriptions.create(
    {channel: "RoomChannel", chat_rooms: chatRoomId}, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log('WebSocketが接続されました');
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
      console.log('WebSocketが切断されました');
    },

    received: function(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log('データが受信されました:', data);
      const messages = document.getElementById('messages');
      console.log(messages);
      messages.insertAdjacentHTML('beforeend', data['message']);
      messages.scrollTop = messages.scrollHeight;
    },

    speak: function(message) {
      return this.perform('speak', {message: message});
      
    }
  });

  window.document.onkeydown = function(event) {
    if(event.key == 'Enter') {
      appRoom.speak(event.target.value);
      event.target.value = '';
      event.preventDefault();
    }
  };
  } else {
    console.log("Action Cable is not connected on this page.");
  }
});
