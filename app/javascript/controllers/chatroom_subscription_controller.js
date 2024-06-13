import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number };
  static targets = ["messages"];
  
  connect() {
    this.subscription = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    );
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`);
    this.scrollToBottom();
    this.markMessagesAsRead();
  }

  markMessagesAsRead() {
    // this.messagesTarget.querySelectorAll('.message-row').forEach((message) => {
      // console.log(message)
      // if (!message.dataset.read) {
        fetch(`/chatrooms/${this.chatroomIdValue}/mark_as_read`, {
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
    //   }
    // });
  }

  resetForm(event) {
    event.target.reset();
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id;
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message);
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
    this.scrollToBottom();

    // Show unread count if chatroom is minimized
    if (this.chatroomTarget && this.chatroomTarget.style.display === "none") {
      this.showUnreadCount();
    }
  }

  #buildMessageElement(currentUserIsSender, message) {
    // <div class="${this.#userStyleClass(currentUserIsSender)}">
    var messageWithTheRightClass = currentUserIsSender ? message : message.replace('sender-style-bubble', 'receiver-style-bubble')
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)} ${this.#userStyleClass(currentUserIsSender)}" data-id="${message.id}" data-read="${message.read}">
        ${messageWithTheRightClass}
      </div>
    `;
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.subscription.unsubscribe();
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start";
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style";
  }

  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  showUnreadCount() {
    const unreadCountElement = document.querySelector('[data-close-icon-target="unreadCount"]');
    if (unreadCountElement) {
      unreadCountElement.style.display = "flex";
    }
  }
}