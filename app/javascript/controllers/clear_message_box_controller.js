import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "messageBox" ]

    clear() {
        this.messageBoxTarget.value = ''
    }
}
