import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="student-course-records"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      group: {
        name: "student-course-records",
        pull: false,
        put: "courses",
        revertClone: false
      }
    })
  }
}
