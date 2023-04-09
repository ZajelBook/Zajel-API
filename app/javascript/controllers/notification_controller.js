import { Controller } from "@hotwired/stimulus"
import { put } from "@rails/request.js"

// Connects to data-controller="notification"
export default class extends Controller {
  static values = { url: String }

  initialize() {
    put(this.urlValue);
    this.element.remove();
  }
}
