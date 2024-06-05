import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="table-links"
export default class extends Controller {

  static targets = ["link"]

  show() {
  }
}
