import consumer from "../channels/action_cable.js";

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
    },

    speak: function(message) {
      return this.perform('speak', {message: message});
      
    }
  });
  
    const formInput = document.getElementById('talk-form'); 
    const submitButton = document.getElementById('send-button'); 

    submitButton.addEventListener('click', function(event) {
      appRoom.speak(formInput.value);
      formInput.value = '';
      event.preventDefault();
    });

  } else {
    console.log("このページではAction Cableが接続されていません。");
  }
});
