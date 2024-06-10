import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["student", "teacher", "btnStudent", "btnTeacher"]

  connect() {
    this.btnStudentTarget.style.backgroundColor = "#4A9D9F"
    this.btnTeacherTarget.classList.add("border")
    this.btnTeacherTarget.classList.add("border-light")
  }

  displayStudent() {
    this.studentTarget.classList.remove("d-none")
    this.teacherTarget.classList.add("d-none")
    this.btnTeacherTarget.style.backgroundColor = ""
    this.btnStudentTarget.classList.remove("border")
    this.btnStudentTarget.classList.remove("border-light")
    this.btnStudentTarget.style.backgroundColor = "#4A9D9F"
    this.btnTeacherTarget.classList.add("border")
    this.btnTeacherTarget.classList.add("border-light")

    }

  displayTeacher() {
      this.studentTarget.classList.add("d-none")
      this.teacherTarget.classList.remove("d-none")
      this.btnStudentTarget.style.backgroundColor = ""
      this.btnTeacherTarget.style.backgroundColor = "#4A9D9F"
      this.btnTeacherTarget.classList.remove("border")
      this.btnStudentTarget.classList.add("border")
      this.btnStudentTarget.classList.add("border-light")
  }

  addSkill() {
  }
}
