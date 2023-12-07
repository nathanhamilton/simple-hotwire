import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { post } from "@rails/request.js"

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
          // Get the current state of the DOM
          let items = Array.from(document.getElementById('student_course_records').children);
          // console.log(`These are the items of the new array: ${JSON.stringify(items)}`)
          // Update the array of items based on the current state of the DOM
          let updatedArray = items.map((item, index) => {
            return { id: item.getAttribute('data-id'), order: index }
          });
          // console.log(`This is the updated array: ${JSON.stringify(updatedArray)}`)
          // Refresh the Sortable.js instance
          sortable.sort(updatedArray);
          let order = sortable.toArray()
          let orderArray = order.map((itemId, index) => {
            return { id: itemId, order: index }
          })
          this.bulkUpdateOrder(orderArray) // Call the updateItems function with the order
        }
      },
      onAdd: (event) => {
        if (event.from.id === 'courses') {
          event.item.children[0].classList.add('mb-5')
          const courseId = event.item.dataset.courseId // Access the data-course-id attribute value
          const index = event.newIndex // Access the new index of the item
          const response = this.createNewStudentCourseRecord(courseId, index) // Call the createNewStudentCourseRecord function with the courseId
          console.log(`This is the response: ${JSON.stringify(response)}`)
          // console.log(event.item.dataIdAttr('data-id').add(response))
        }
      },
    })
  }

  async createNewStudentCourseRecord(courseId, index) {
    // Make an AJAX call to create a new student course record
    const currentUrl = new URL(document.URL)
    const studentId = currentUrl.pathname.split('/')[2]
    let url = `/students/${studentId}/student_course_records`
    let data = {
      student_id: studentId,
      course_id: courseId,
      order: index
    }
    await post( url,
      {
        body: JSON.stringify(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      }
    )
    .then((response) => {
      console.log(response)
      return response
    })
    .catch((error) => {
      console.log(error)
    })
  }

  async bulkUpdateOrder(orderArray) {
    // Make an AJAX call to update the items in the specified order
    const currentUrl = new URL(document.URL)
    const studentId = currentUrl.pathname.split('/')[2]
    let url = `/students/${studentId}/student_course_records/bulk_update_order`
    let data = {
      order_array: JSON.stringify(orderArray)
    }
    await post(
      url,
      {
        body: JSON.stringify(data),
      }
    )
    .then((response) => {
      console.log(response)
    })
    .catch((error) => {
      console.log(error)
    })
  }
}
