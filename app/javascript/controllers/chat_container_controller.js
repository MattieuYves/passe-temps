import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-container"
export default class extends Controller {
  connect() {
    this.element.controller = this;
  }

  refresh(html) {
    this.element.innerHTML = html;
  }
}