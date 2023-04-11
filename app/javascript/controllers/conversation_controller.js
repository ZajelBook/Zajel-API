import { Controller } from "@hotwired/stimulus"
import consumer from '../channels/consumer';
import {formatDistance} from "date-fns";

// Connects to data-controller="conversation"
export default class extends Controller {
  static values = { recordId: Number, userId: Number }

  connect() {
    let existingSubscription = this._find_active_subscriptions();

    if (existingSubscription.length !== 0) {
      // Subscription already exists, so you don't need to create a new one
      this.channel = existingSubscription[0]
    } else {
      // No existing subscription found, create a new one
      this._create_new_subscription();
    }
  }

  disconnect() {
    let existingSubscription = this._find_active_subscriptions();

    consumer.subscriptions.remove(existingSubscription[0]);

    consumer.disconnect();
  }

  _cableConnected() {
    // Called when the subscription is ready for use on the server
  }

  _cableDisconnected() {
    // Called when the subscription has been terminated by the server
  }

  _cableReceived(data) {
    // Called when there's incoming data on the websocket for this channel
    let list = document.getElementById('list');

    if (data.object.sender_id == this.userIdValue) {
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

  _create_new_subscription() {
    this.channel = consumer.subscriptions.create({ channel: 'ConversationChannel', id: this.recordIdValue },{
      connected: this._cableConnected.bind(this),
      disconnected: this._cableDisconnected.bind(this),
      received: this._cableReceived.bind(this),
    });
  }

  _find_active_subscriptions() {
    let identifier = JSON.stringify({ channel: 'ConversationChannel', id: this.recordIdValue })
    return consumer.subscriptions.findAll(identifier);
  }
}