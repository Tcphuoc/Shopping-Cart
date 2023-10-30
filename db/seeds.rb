# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Shop.create(first_name: 'Truong', last_name: 'Phuoc', phone: '0938543184',
                   address: '123 Ngo Gia Tu, phuong 2, quan 10, TP.HCM', email: 'tcphuoc@gmail.com', password: '12345678', password_confirmation: '12345678')

tshirt_category = Category.create(name: "T-Shirt", shop_id: 1)
sweater_category = Category.create(name: "Sweater", shop_id: 1)

6.times.each do |i|
  tshirt = Product.new(name: "Shirt #{i+1}", description: "100% cotton T-shirt, pre-washed for a casual look. Contrasting color block design.", price: 100000, stock: 10+i, shop_id: 1)
  tshirt.image.attach(
    io: File.open(Rails.root.join("public/tshirt/tshirt_#{i+1}.jpg")),
    filename: "tshirt_#{i+1}.jpg"
  )
  tshirt.save
  tshirt.add_category(tshirt_category)

  sweater = Product.new(name: "Sweater #{i+1}", description: "Fine texture and stunning coloring. Designed with traditional sweatshirt details.", price: 200000, stock: 10+i, shop_id: 1)
  sweater.image.attach(
    io: File.open(Rails.root.join("public/sweater/sweater_#{i+1}.jpg")),
    filename: "sweater_#{i+1}.jpg"
  )
  sweater.save
  sweater.add_category(sweater_category)
end
