import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["inboxChat"];

  close() {
    this.inboxChatTarget.style.display = "none";
  }
}
