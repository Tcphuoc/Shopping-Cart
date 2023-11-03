import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["product_id", "quantity"]

  add_to_cart(event){
    event.preventDefault()
    $.ajax({
      url: "/carts/new",
      method: "GET",
      dataType: "json",
      data: {
        product_id: this.product_idTarget.value,
        quantity: this.quantityTarget.value
      },
      error: function(xhr, status, error){
        if(error == "Unauthorized"){
          Swal.fire({
            icon: 'error',
            title: 'Haven\'t signed in your account yet',
            confirmButtonText: '<a href="/users/sign_in">Sign in</a>'
          })
        }
      },
      success: function(response){
        if(response.status == 'success'){
          console.log($('#cart-items'))
          document.getElementById("cart-items").innerHTML = response.items
          Swal.fire({
            icon: 'success',
            title: response.message,
            confirmButtonText: `<p>OK<p>`
          })
        } else {
          Swal.fire({
            icon: 'error',
            title: response.message,
            confirmButtonText: `<p>OK<p>`
          })
        }
      }
    })
  }
}
