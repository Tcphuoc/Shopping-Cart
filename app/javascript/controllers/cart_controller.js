import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["product_id", "quantity", "stock"]
  sweet_alert(type, message, confirm_button = '<p>OK</p>'){
    Swal.fire({
      icon: type,
      title: message,
      confirmButtonText: confirm_button
    })
  }

  add_to_cart(event){
    event.preventDefault()
    let self = this
    $.ajax({
      url: "/carts/new",
      method: "GET",
      dataType: "json",
      data: {
        cart: {
          product_id: this.product_idTarget.value,
          quantity: this.quantityTarget.value
        }
      }
    }).done(function(response) {
      self.quantityTarget.value = 1
      if(response.status == 'success'){
        document.getElementById("cart-items").innerHTML = response.items
        self.sweet_alert('success', response.message)
      } else if(response.status == 'fail') {
        self.sweet_alert('error', response.message)
      }
    }).fail(function(xhr, status, error) {
      if(error == "Unauthorized"){
        self.sweet_alert('error', 'Haven\'t signed in your account yet', '<a href="/users/sign_in">Sign in</a>')
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
        cart: {
          product_id: this.product_idTarget.value,
          quantity: this.quantityTarget.value,
          buy_now: true
        }
      }
    }).done(function(response) {
      self.quantityTarget.value = 1
      if(response.status == 'redirect'){
        window.location.href = '/orders/new'
      } else if(response.status == 'fail') {
        self.sweet_alert('error', response.message)
      }
    }).fail(function(xhr, status, error) {
      if(error == "Unauthorized"){
        self.sweet_alert('error', 'Haven\'t signed in your account yet', '<a href="/users/sign_in">Sign in</a>')
      }
    })
  }

  add(){
    this.quantityTarget.value = parseInt(this.quantityTarget.value) + 1
  }

  minus(){
    this.quantityTarget.value = parseInt(this.quantityTarget.value) - 1
  }
}
