import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error"]

  connect(){
    let inputs = this.inputTargets
    inputs.forEach(input => {
      if (input.parentNode.className == "field_with_errors"){
        input.classList.add('is-invalid')
      } else {
        input.classList.remove('is-invalid')
      }
    });
  }
}
