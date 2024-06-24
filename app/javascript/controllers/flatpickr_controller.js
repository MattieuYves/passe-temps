import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js";

export default class extends Controller {
  static targets = ["startDateInput"]

  connect() {
    // console.log("Flatpickr controller connected");
    this.initializeFlatpickr();
    document.getElementById('exampleModal').addEventListener('shown.bs.modal', this.initializeFlatpickr.bind(this));
  }

  initializeFlatpickr() {
    flatpickr(this.startDateInputTarget, {
      minDate: "today",
      dateFormat: "Y-m-d",
      defaultDate: "today",
      inline: true,
      locale: French,
      onReady: this.simulateClickOnToday.bind(this)
    });
  }

  simulateClickOnToday(selectedDates, dateStr, instance) {
    // console.log("simulateClickOnToday called");
    const todayElement = instance.calendarContainer.querySelector('.flatpickr-day.today');
    if (todayElement) {
      todayElement.click();
    }
  }
}
