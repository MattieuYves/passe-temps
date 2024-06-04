import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static classes = [ "sidebar" ]


  connect() {
    console.log("Hello from the sidebar controller!")
  }

  growSidebar(){
    this.element.classList()
  }

  normalSidebar(){

  }
}
