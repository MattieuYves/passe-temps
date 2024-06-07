import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["message"];

  connect() {
    this.markMessagesAsRead();
  }

  markMessagesAsRead() {
    this.messageTargets.forEach((message) => {
      if (!message.dataset.read) {
        fetch(`/messages/${message.dataset.id}/read`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
          }
        }).then(response => {
          if (response.ok) {
            message.dataset.read = true;
            message.classList.remove("unread");
          }
        });
      }
    });
  }
}
