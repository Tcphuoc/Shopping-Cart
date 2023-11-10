import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  show(){
    Fancybox.bind('[data-fancybox="gallery"]', {
      //
    });
  }

  preview(event){
    if(event.target.files.length > 0){
      return URL.createObjectURL(event.target.files[0])
    }
  }

  preview_image_1(event){
    document.getElementsByClassName("pre-image")[0].src = this.preview(event)
  }

  preview_image_2(event){
    document.getElementsByClassName("pre-image")[1].src = this.preview(event)
  }

  preview_image_3(event){
    document.getElementsByClassName("pre-image")[2].src = this.preview(event)
  }

  preview_image_4(event){
    document.getElementsByClassName("pre-image")[3].src = this.preview(event)
  }

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
