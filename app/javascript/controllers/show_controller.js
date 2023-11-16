import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  show(){
    Fancybox.bind('[data-fancybox="gallery"]', {
      //
    });
  }
}
