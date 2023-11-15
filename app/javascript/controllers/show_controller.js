import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  show(){
    console.log('hello')
    Fancybox.bind('[data-fancybox="gallery"]', {
      //
    });
  }
}
