import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {

  static targets = ["id"]

  static values = {
    chatroom: Array
  }
  connect() {
  }

  get chatContainerController() {
    const element = document.querySelector('[data-controller="chat-container"]')
    if (!element) return;

    return element.controller;
  }

  reveal(event) {
    console.log(event.currentTarget.dataset.chatId)
    fetch(`/chatrooms/${event.currentTarget.dataset.chatId}`, {
      headers: {
        'Accept': 'application/json'
      }
    })
      .then(response => response.json())
      .then(data => {
        this.chatContainerController.refresh(data.html)
    })
  }
}
