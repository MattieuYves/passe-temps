import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="inbox"
export default class extends Controller {
  static targets = ["inboxLinksClose"];

  toggle() {
    this.inboxLinksCloseTarget.parentElement.querySelector('.wrapper-links').classList.toggle('inbox-links-close');
    this.inboxLinksCloseTarget.parentElement.querySelector('.wrapper-links').classList.toggle('inbox-links-open');
    // this.inboxLinksCloseTarget.classList.toggle('inbox-links-open');
    // this.inboxLinksCloseTarget.parentElement.classList.toggle('inbox-links-close');
    this.inboxLinksCloseTarget.classList.toggle('fa-comments');
    this.inboxLinksCloseTarget.classList.toggle('fa-xmark');

    // this.inboxLinksCloseTarget.style.height = 'auto';
  }
}
