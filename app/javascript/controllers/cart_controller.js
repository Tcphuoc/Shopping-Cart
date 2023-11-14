import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["product_id", "quantity", "stock", "id"]

  connect(){
    console.log(`${this.product_idTarget.value} - ${this.stockTarget.value}`)
    if(parseInt(this.stockTarget.value) == 0){
      document.getElementById('btn-add').disabled = true
      document.getElementById('btn-minus').disabled = true
      this.quantityTarget.value = 0
      document.getElementById('btn-buy-now').disabled = true
      document.getElementById('btn-add-to-cart').disabled = true
      document.getElementById("btn-buy-now").innerText = 'Sold out'
      document.getElementById("btn-add-to-cart").innerText = 'Sold out'
    }
  }

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
        document.getElementById("btn-add").disabled = false
      }
    }).fail(function(xhr, status, error) {
      if(error == "Unauthorized"){
        self.sweet_alert('error', 'Haven\'t signed in your account yet', '<a href="/users/sign_in">Sign in</a>')
      }
    })
  }

  buy_now(event){
    event.preventDefault()
    let self = this
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

  update_cart(event){
    event.preventDefault()
    $.ajax({
      url: `/carts/${this.idTarget.value}`,
      method: "PUT",
      dataType: "json",
      data: {
        cart: {
          product_id: this.product_idTarget.value,
          quantity: this.quantityTarget.value
        }
      }
    }).done(function (response) {
      console.log(response)
      document.getElementById("cart-items").innerHTML = response.items
      document.getElementById("cart").innerHTML = response.html
    }).fail(function (xhr, status, error) {
      console.error(error)
    })
  }

  add(){
    this.quantityTarget.value = parseInt(this.quantityTarget.value) + 1
    if (parseInt(this.quantityTarget.value) >= parseInt(this.stockTarget.value)){
      document.getElementById("btn-add").disabled = true
    }
    if (parseInt(this.quantityTarget.value) > 1){
      document.getElementById("btn-minus").disabled = false
    }
  }

  minus(){
    this.quantityTarget.value = parseInt(this.quantityTarget.value) - 1
    if (parseInt(this.quantityTarget.value) < parseInt(this.stockTarget.value)){
      document.getElementById("btn-add").disabled = false
    }
    if (parseInt(this.quantityTarget.value) <= 1){
      document.getElementById("btn-minus").disabled = true
    }
  }
}
