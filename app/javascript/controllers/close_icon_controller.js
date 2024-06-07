import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["inboxChat", "chatroom", "unreadCount"];

  close() {
    this.inboxChatTarget.style.display = "none";
  }

  toggle() {
    if (this.chatroomTarget.style.display === "none") {
      this.chatroomTarget.style.display = "block";
      this.inboxChatTarget.style.height = "auto"; // Ajustez la hauteur selon vos besoins
      if (this.hasUnreadCountTarget) {
        this.unreadCountTarget.style.display = "none";
      }
    } else {
      this.chatroomTarget.style.display = "none";
      this.inboxChatTarget.style.height = "40px"; // Ajustez la hauteur à 40px
    }
  }

  showUnreadCount() {
    if (this.hasUnreadCountTarget) {
      this.unreadCountTarget.style.display = "flex";
    }
  }

  hideUnreadCount() {
    if (this.hasUnreadCountTarget) {
      this.unreadCountTarget.style.display = "none";
    }
  }
}