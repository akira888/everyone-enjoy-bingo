import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {

  adjustInputNumber(event) {
    if (event.target.type !== "number") return
    const form = event.target

    if (parseInt(form.value) < parseInt(form.min)) {
      alert("Please enter a number greater than "+form.min)
      form.value = form.min
    }
    if (parseInt(form.value) > parseInt(form.max)) {
      alert("Please enter a number less than "+form.max)
      form.value = form.max
    }
  }
}
