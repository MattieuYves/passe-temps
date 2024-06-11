import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slot"
export default class extends Controller {
  static targets = ["date", "list", "radio", "label"]
  static values = { id: Number }

  connect() {
    console.log(this.dateTarget);
  }

  updateList() {
    this.date = this.dateTarget.value
    const url = `/skills/${this.idValue}?date=${this.dateTarget.value}`
    fetch(url, {headers: {"Accept": "application/json"}})
    .then(response => response.json())
    .then((data) => {
      this.listTarget.classList.remove("d-none")
      this.listTarget.innerHTML = data.list
    })
  }
  
  fillInput(event) {
    // this.radio = this.radioTargets.find((el) => {
    //   return el === event.currentTarget
    // })

    this.label = this.labelTargets.find((el) => {
      return el === event.currentTarget
    })
    
    this.label.previousElementSibling.checked = true
    this.dateTarget.value = this.date + ` ${this.label.previousElementSibling.value}`

    if (this.label.previousElementSibling.checked === true) {
      this.labelTargets.forEach((element) => {
        element.classList.remove("selected")
      });
      this.label.classList.add("selected")
    }
  }
}
