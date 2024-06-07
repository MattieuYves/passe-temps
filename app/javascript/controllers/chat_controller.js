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
    const chatId = event.currentTarget.dataset.chatId;
    console.log(chatId);
    fetch(`/chatrooms/${chatId}`, {
      headers: {
        'Accept': 'application/json'
      }
    })
      .then(response => response.json())
      .then(data => {
        this.chatContainerController.refresh(data.html);
        this.markMessagesAsRead(chatId);
        this.scrollToBottom();
        this.hideUnreadCount();
      });
  }

  markMessagesAsRead(chatId) {
    fetch(`/chatrooms/${chatId}/mark_as_read`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      }
    }).then(response => {
      if (response.ok) {
        document.querySelector(`[data-chat-id="${chatId}"] .unread-indicator`).style.display = 'none';
      }
    });
  }

  scrollToBottom() {
    const messagesContainer = document.querySelector('[data-chatroom-subscription-target="messages"]');
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }

  hideUnreadCount() {
    const unreadCountElement = document.querySelector('[data-close-icon-target="unreadCount"]');
    if (unreadCountElement) {
      unreadCountElement.style.display = "none";
    }
  }
}

