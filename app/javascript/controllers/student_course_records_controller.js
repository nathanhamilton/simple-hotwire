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
          console.log('this is sortable')
          console.log(sortable)
          let order = localStorage.getItem(sortable.options.group.name)
          console.log('This is the get order')
          console.log(order)
          return order ? order.split('|') : []
        },
        set: (sortable) => {
          console.log('sortable for the set function')
          console.log(sortable.el)
          let order = sortable.toArray()
          console.log('This is the set order')
          console.log(order)
          let orderArray = order.map((itemId, index) => {
            // Work with this to determine why the sortable.el.children[itemId] is not working
            console.log('This is the sortable.el.children[itemId]')
            console.log(itemId)
            console.log({ id: itemId, order: index })
            return { id: itemId, order: index }
          })
          localStorage.setItem(sortable.options.group.name, order.join('|'))
          console.log('This is the order array')
          console.log(orderArray)
          this.bulkUpdateOrder(orderArray) // Call the updateItems function with the order
        }
      },
      onAdd: (event) => {
        console.log(event.from)
        console.log(event.from.id)
        console.log(event)
        if (event.from.id === 'courses') {
          event.item.classList.add('mb-5')
        }
      },
    })
  }

  bulkUpdateOrder(orderArray) {
    // Make an AJAX call to update the items in the specified order
    const currentUrl = new URL(document.URL)
    const studentId = currentUrl.pathname.split('/')[2]
    let url = `/students/${studentId}/student_course_records/bulk_update_order`
    let token = document.querySelector('meta[name="csrf-token"]').content
    let data = {
      order_array: JSON.stringify(orderArray)
    }
    console.log(data)
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
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
