import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["inboxChat", "inboxLinksClose", "inboxLinksOpen"];

  connect() {
  }

  close() {
    this.inboxChatTarget.style.display = "none";
  }
}
