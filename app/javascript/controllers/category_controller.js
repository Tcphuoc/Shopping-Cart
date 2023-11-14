import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  confirm_delete(event){
    event.preventDefault()
    let element = event.target
    let index = element.dataset.slideIndex
    Swal.fire({
      title: "Are you sure to delete this product?",
      showDenyButton: true,
      showCancelButton: true,
      showConfirmButton: false,
      denyButtonText: 'Delete'
    }).then((result) => {
      if (result.isDenied) {
        document.getElementById(`delete-${index}`).submit()
      }
    });
  }
}
