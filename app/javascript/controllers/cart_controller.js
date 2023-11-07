import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["product_id", "quantity", "stock"]

  add_to_cart(event){
    event.preventDefault()
    $.ajax({
      url: "/carts/new",
      method: "GET",
      dataType: "json",
      data: {
        cart: {
          product_id: this.product_idTarget.value,
          quantity: this.quantityTarget.value
        }
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
          document.getElementById("cart-items").innerHTML = response.items
          Swal.fire({
            icon: 'success',
            title: response.message,
            confirmButtonText: '<p>OK</p>'
          })
        } else if(response.status == 'fail') {
          Swal.fire({
            icon: 'error',
            title: response.message,
            confirmButtonText: '<p>OK</p>'
          })
        }
      }
    })
  }

  buy_now(event){
    event.preventDefault()
    $.ajax({
      url: "/carts/new",
      method: "GET",
      dataType: "json",
      data: {
        product_id: this.product_idTarget.value,
        quantity: this.quantityTarget.value,
        buy_now: true
      },
      error: function(xhr, status, error){
        console.error(error)
        if(error == "Unauthorized"){
          Swal.fire({
            icon: 'error',
            title: 'Haven\'t signed in your account yet',
            confirmButtonText: '<a href="/users/sign_in">Sign in</a>'
          })
        }
      },
      success: function(response){
        console.log(response)
        if(response.status == 'redirect'){
          window.location.href = '/orders/new'
        } else if(response.status == 'fail') {
          Swal.fire({
            icon: 'error',
            title: response.message,
            confirmButtonText: '<p>OK</p>'
          })
        }
      }
    })
  }
}
