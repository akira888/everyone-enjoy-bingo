import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="award"
export default class extends Controller {
  static targets = ["awardForm"]
  changeInputList(event) {
    const listSize = parseInt(event.target.value)
    let awards = this.awardFormTargets,
      baseElement = awards.findLast(e => !!e)

    if (listSize > awards.length) {
      for (let i = awards.length; i < listSize; i++) {
        let newElement = baseElement.cloneNode(true)
        let newLabel = newElement.querySelector("label"),
          newTitle = newElement.querySelector("input[type=text]"),
          newOrder = newElement.querySelector("input[type=hidden]")
        newLabel.htmlFor = newLabel.htmlFor.replace(/\d+/, i)
        newTitle.id = newTitle.id.replace(/\d+/, i)
        newTitle.name = newTitle.name.replace(/\d+/, i)
        newTitle.value = ""
        newOrder.name = newOrder.name.replace(/\d+/, i)
        newOrder.value = i+1 // order starts at 1
        // console.log(newLabel, newTitle.name, newOrder.name)
        baseElement.after(newElement)
        baseElement = newElement
      }
    }

    if (listSize < awards.length) {
      for (let i = awards.length-1; i >= listSize; i--) {
        awards[i].remove()
        if(i===0) break // don't remove the first element
      }
    }
  }
}
