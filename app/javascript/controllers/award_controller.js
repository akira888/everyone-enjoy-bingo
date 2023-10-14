import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="award"
export default class extends Controller {
  static targets = ["awardForm"]
  static classes = ["hidden"]

  initialize() {
    this.labelSelector = "label"
    this.titleSelector = "input[type=text]"
    this.orderNumberSelector = "input[name$='[order_number]']"
    this.destroySelector = "input[name$='[_destroy]']"
  }
  changeInputList(event) {
    const listSize = parseInt(event.target.value)
    let awards = this.awardFormTargets,
      baseElement = awards.findLast(e => !!e)

    if (listSize > awards.length) {
      for (let i = awards.length; i < listSize; i++) {
        let newElement = baseElement.cloneNode(true)
        let newLabel = newElement.querySelector(this.labelSelector),
          newTitle = newElement.querySelector(this.titleSelector),
          newOrder = newElement.querySelector(this.orderNumberSelector),
          newDestroy = newElement.querySelector(this.destroySelector);

        newLabel.htmlFor = newLabel.htmlFor.replace(/\d+/, i)
        newTitle.id = newTitle.id.replace(/\d+/, i)
        newTitle.name = newTitle.name.replace(/\d+/, i)
        newTitle.value = ""
        newOrder.id = newOrder.id.replace(/\d+/, i)
        newOrder.name = newOrder.name.replace(/\d+/, i)
        newOrder.value = i+1 // order starts at 1
        newDestroy.id = newDestroy.id.replace(/\d+/, i)
        newDestroy.name = newDestroy.name.replace(/\d+/, i)
        newDestroy.value = 0
        newElement.classList.remove(this.hiddenClass)
        baseElement.after(newElement)
        baseElement = newElement
      }
    } else if (listSize <= awards.length) {
      for (let i = awards.length-1; i >= listSize; i--) {
        awards[i].classList.add(this.hiddenClass)
        awards[i].querySelector(this.titleSelector).required = false
        awards[i].querySelector(this.destroySelector).value = 1
        if(i===0) break // don't remove the first element
      }
      for (let i = 0; i < listSize; i++) {
        awards[i].classList.remove(this.hiddenClass)
        awards[i].querySelector(this.titleSelector).required = true
        awards[i].querySelector(this.destroySelector).value = 0
      }
    }
  }
}
