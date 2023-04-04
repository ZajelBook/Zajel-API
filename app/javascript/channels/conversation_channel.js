import consumer from "./consumer"
import Cookies from 'js-cookie'
import { formatDistance } from 'date-fns'

var url = window.location.href;
let id = url.slice(url.length - 10, url.length - 9);
let user_id = Cookies.get('user_id');

consumer.subscriptions.create({ channel: 'ConversationChannel', id: id }, {
    connected() {
        // Called when the subscription is ready for use on the server
        console.log("ConversationChannel");
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        // Called when there's incoming data on the websocket for this channel
        let list = document.getElementById('list');

        if (data.object.sender_id == user_id) {
            list.innerHTML += `
            <div class="d-flex justify-content-end mb-4">
            <div class="msg_cotainer_send text-center">
            ${data.object.content}
            <span class="msg_time_send">${formatDistance(new Date(), new Date(data.object.created_at))} ago</span>
            </div>
            </div>
            `
        } else {
            list.innerHTML += `
            <div class="d-flex justify-content-start mb-4">
            <div class="msg_cotainer text-center">
            ${data.object.content}
            <span class="msg_time">${formatDistance(new Date(), new Date(data.object.created_at))} ago</span>
            </div>
            </div>
            `
        }

        let objDiv = document.getElementById('list');
        objDiv.scrollTop = objDiv.scrollHeight;
    }
});
