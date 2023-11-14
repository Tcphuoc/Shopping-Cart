import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  show(){
    Fancybox.bind('[data-fancybox="gallery"]', {
      //
    });
  }

  connect(){
    this.check_no_image(1)
    this.check_no_image(2)
    this.check_no_image(3)
  }
  
  check_no_image(index){
    if($('.pre-image')[index].classList.contains('no-image')){
      $('.delete-image')[index-1].classList.add('d-none')
    }
  }

  preview(event){
    if(event.target.files.length > 0){
      return URL.createObjectURL(event.target.files[0])
    }
  }

  preview_image_1(event){
    $('.pre-image')[0].src = this.preview(event)
  }

  preview_image_2(event){
    $('.pre-image')[1].src = this.preview(event)
    $('.delete-image')[0].classList.remove('d-none')
    $('.remove-image')[0].value = false
  }

  preview_image_3(event){
    $('.pre-image')[2].src = this.preview(event)
    $('.delete-image')[1].classList.remove('d-none')
    $('.remove-image')[1].value = false
  }

  preview_image_4(event){
    $('.pre-image')[3].src = this.preview(event)
    $('.delete-image')[2].classList.remove('d-none')
    $('.remove-image')[2].value = false
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

  remove_image(field, index){
    if(field.value == 'false'){
      Swal.fire({
        title: "Are you sure to delete this image?",
        showDenyButton: true,
        showCancelButton: true,
        showConfirmButton: false,
        denyButtonText: 'Delete'
      }).then((result) => {
        if (result.isDenied) {
          field.value = true
          $('.pre-image')[index].src = '/assets/no_image.png'
          $('.delete-image')[index-1].classList.add('d-none')
          $('.image-uploaded')[index].value = ''
        }
      });
    }
  }

  remove_image_2(){
    this.remove_image($('.remove-image')[0], 1)
  }

  remove_image_3(){
    this.remove_image($('.remove-image')[1], 2)
  }

  remove_image_4(){
    this.remove_image($('.remove-image')[2], 3)
  }
}
