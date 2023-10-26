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

  checkEmptyInput(input){
    if(input.value == "" && input.name != "user[password]" && input.name != "user[password_confirmation]"){
      input.classList.add('is-invalid')
      return true
    } else {
      input.classList.remove('is-invalid')
      return false
    }
  }

  validateInput(){
    let inputs = this.inputTargets
    let result = true
    inputs.forEach(input => {
      if(this.checkEmptyInput(input) === true){
        result = false
      }
    })
    return result
  }

  submit(){
    this.validateInput()
    alert(`Hi ${$('#user_first_name').val()}`)
  }
}
