import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {

  static targets = ["id"]

  static values = {
    chatroom: Array
  }
  connect() {
  }

  reveal(event) {
    console.log(this.chatroomValue);
    console.log(this.idTargets)
  }
}
