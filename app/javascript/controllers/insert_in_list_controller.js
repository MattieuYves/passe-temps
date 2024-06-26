import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["skills", "form", "close", "accept", "reject", "bookings", "modal"]

  connect() {
  }

  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {

        if (data.inserted_item) {
          // console.log(data)
          this.closeTarget.click();
        //   // beforeend could also be dynamic with Stimulus values
          this.element.innerHTML = data.inserted_item
        }

        // console.log(data.form)
        this.modalTarget.outerHTML = data.form
      })
  }

  updateBooking(event) {
    event.preventDefault();

    // console.log(event.currentTarget)

    fetch(event.currentTarget.action, {
      method: "PATCH", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(event.currentTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          // beforeend could also be dynamic with Stimulus values
          this.element.innerHTML = data.inserted_item
        }
        // this.formTarget.outerHTML = data.form
      })
      var modal = new bootstrap.Modal(document.getElementById('animationAccept'));
      modal.show();
  }
}
