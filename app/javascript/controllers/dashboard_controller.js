import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["student", "teacher"]

  connect() {
  }

  displayStudent() {
    this.studentTarget.classList.remove("d-none")
    this.teacherTarget.classList.add("d-none")
  }

  displayTeacher() {
    this.studentTarget.classList.add("d-none")
    this.teacherTarget.classList.remove("d-none")
  }
}
