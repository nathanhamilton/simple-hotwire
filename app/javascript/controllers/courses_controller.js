import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="courses"
export default class extends Controller {
  connect() {
    let name = this.element.dataset.name
    // I need to create a new Sortable instance for each list and parse out each name.
    // Another option is to create a stimulus controller for each list and call sortable in each controller. (DO THIS)
    Sortable.create(this.element, {
      group: {
        name: "courses",
        pull: "student-course-records",
        put: false,
        revertClone: false
      }
    })
  }
}
