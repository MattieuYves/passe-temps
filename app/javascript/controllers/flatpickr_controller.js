import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["startDateInput"]
  connect() {
    flatpickr(this.startDateInputTarget, {
      minDate: "today",
      dateFormat: "Y-m-d",
      inline: true
    })
  }
}