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
        revertClone: false,
        dataIdAttr: 'data-id' // This is the data-id attribute on the HTML element for student-course-records
      },
      store: {
        get: (sortable) => {
          let order = localStorage.getItem(sortable.options.group.name)
          return order ? order.split('|') : []
        },
        set: (sortable) => {
          let order = sortable.toArray()
          let orderArray = order.map((itemId, index) => {
            return { id: itemId, order: index }
          })
          this.bulkUpdateOrder(orderArray) // Call the updateItems function with the order
        }
      },
      onAdd: (event) => {
        if (event.from.id === 'courses') {
          event.item.classList.add('mb-5')
          const courseId = console.log(event.item.dataset.courseId) // Access the data-course-id attribute value
          this.createNewStudentCourseRecord(courseId) // Call the createNewStudentCourseRecord function with the courseId
        }
      },
    })
  }

  createNewStudentCourseRecord(courseId) {
    // Make an AJAX call to create a new student course record
    const currentUrl = new URL(document.URL)
    const studentId = currentUrl.pathname.split('/')[2]
    let url = `/students/${studentId}/student_course_records`
    let data = {
      student_id: studentId,
      course_id: courseId
    }
    this.makePostCall(url, data)
  }

  bulkUpdateOrder(orderArray) {
    // Make an AJAX call to update the items in the specified order
    const currentUrl = new URL(document.URL)
    const studentId = currentUrl.pathname.split('/')[2]
    let url = `/students/${studentId}/student_course_records/bulk_update_order`
    let data = {
      order_array: JSON.stringify(orderArray)
    }
    this.makePostCall(url, data)
  }

  makePostCall(url, data) {
    let token = document.querySelector('meta[name="csrf-token"]').content
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify(data)
    })
    .then(response => response)
    .then(data => {
      console.log(data)
      // Handle the response data if needed
    })
    .catch(error => {
      console.error(error)
      // Handle the error if needed
    })
  }
}
