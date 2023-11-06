# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Shop.create(first_name: 'Truong', last_name: 'Phuoc', phone: '0938543184',
                   address: '123 Ngo Gia Tu, phuong 2, quan 10, TP.HCM', email: 'tcphuoc@gmail.com', password: '12345678', password_confirmation: '12345678')

tshirt_category = Category.create(name: 'T-Shirt', shop_id: 1, slug: 'tshirt')
sweater_category = Category.create(name: 'Sweater', shop_id: 1, slug: 'sweater')
jeans_category = Category.create(name: 'Jeans', shop_id: 1, slug: 'jeans')
pants_category = Category.create(name: 'Pants', shop_id: 1, slug: 'pants')
polo_category = Category.create(name: 'Polo Shirt', shop_id: 1, slug: 'polo_shirt')
short_category = Category.create(name: 'Short', shop_id: 1, slug: 'short')

def create_product(param, index, category)
  product = Product.new(param)
  4.times.each do |i|
    product.images.attach(
    io: File.open(Rails.root.join("public/#{category.slug}/#{index}/#{param[:slug]}_#{i+1}.jpg")),
    filename: "#{param[:slug]}_1.jpg"
  )
  end
  product.save
  product.add_category(category)
end

6.times.each do |i|
  index = i + 1

  tshirt_param = {
    name: "T-Shirt #{index}",
    description: '100% cotton T-shirt, pre-washed for a casual look. Contrasting color block design.',
    price: 100000,
    stock: 10+i,
    shop_id: 1,
    slug: "tshirt_#{index}"
  }
  create_product(tshirt_param, index, tshirt_category)

  sweater_param = {
    name: "Sweater #{index}",
    description: 'Fine texture and stunning coloring. Designed with traditional sweatshirt details.',
    price: 200000,
    stock: 10+i,
    shop_id: 1,
    slug: "sweater_#{index}"
  }
  create_product(sweater_param, index, sweater_category)

  jeans_param = {
    name: "Jeans #{index}",
    description: 'Incredible stretch for a comfortable, flattering fit. Buttons and stitching in chic tones for a sophisticated look.',
    price: 350000,
    stock: 10+i,
    shop_id: 1,
    slug: "jeans_#{index}"
  }
  create_product(jeans_param, index, jeans_category)

  pants_param = {
    name: "Pants #{index}",
    description: 'Sleek and stretchy. Versatile pants for comfort at home or the office.',
    price: 320000,
    stock: 10+i,
    shop_id: 1,
    slug: "pants_#{index}"
  }
  create_product(pants_param, index, pants_category)

  polo_param = {
    name: "Polo shirt #{index}",
    description: 'A smooth and durable blend of cotton and recycled polyester. This wardrobe staple is always evolving.',
    price: 250000,
    stock: 10+i,
    shop_id: 1,
    slug: "polo_shirt_#{index}"
  }
  create_product(polo_param, index, polo_category)

  short_param = {
    name: "Short #{index}",
    description: 'Quick-drying fabric that allows ease of movement. Versatile pants for relaxing at home or wearing out and about.',
    price: 210000,
    stock: 10+i,
    shop_id: 1,
    slug: "short_#{index}"
  }
  create_product(short_param, index, short_category)
end
