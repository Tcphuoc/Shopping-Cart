Shop.create(first_name: 'Truong', last_name: 'Phuoc', phone: '0938543184',
                   address: '123 Ngo Gia Tu, phuong 2, quan 10, TP.HCM', email: 'tcphuoc0511@gmail.com', password: '12345678', password_confirmation: '12345678')

tshirt_category = Category.create(name: 'T-Shirt', shop_id: 1, slug: 'tshirt')
sweater_category = Category.create(name: 'Sweater', shop_id: 1, slug: 'sweater')
jeans_category = Category.create(name: 'Jeans', shop_id: 1, slug: 'jeans')
pants_category = Category.create(name: 'Pants', shop_id: 1, slug: 'pants')
polo_category = Category.create(name: 'Polo Shirt', shop_id: 1, slug: 'polo_shirt')
short_category = Category.create(name: 'Short', shop_id: 1, slug: 'short')

def create_product(index, name, description, price, stock, slug, category)
  params = {
    name: "#{name} #{index}",
    description: description,
    price: price,
    stock: stock,
    shop_id: 1,
    category_id: category.id,
    slug: "#{slug}_#{index}"
  }
  product = Product.new(params)
  product.image1 = File.open(Rails.root.join("public/images/#{category.slug}/#{index}/#{params[:slug]}_1.jpg"))
  product.image2 = File.open(Rails.root.join("public/images/#{category.slug}/#{index}/#{params[:slug]}_2.jpg"))
  product.image3 = File.open(Rails.root.join("public/images/#{category.slug}/#{index}/#{params[:slug]}_3.jpg"))
  product.image4 = File.open(Rails.root.join("public/images/#{category.slug}/#{index}/#{params[:slug]}_4.jpg"))
  product.save
end

6.times.each do |i|
  index = i + 1

  tshirt_content = '100% cotton T-shirt, pre-washed for a casual look. Contrasting color block design.'
  create_product(index, 'T-Shirt', tshirt_content, 100000, 10, 'tshirt', tshirt_category)

  sweater_content = 'Fine texture and stunning coloring. Designed with traditional sweatshirt details.'
  create_product(index, 'Sweater', sweater_content, 200000, 15, 'sweater', sweater_category)

  jeans_content = 'Incredible stretch for a comfortable, flattering fit. Buttons and stitching in chic tones for a sophisticated look.'
  create_product(index, 'Jeans', jeans_content, 350000, 12, 'jeans', jeans_category)

  pants_content = 'Sleek and stretchy. Versatile pants for comfort at home or the office.'
  create_product(index, 'Pants', pants_content, 320000, 20, 'pants', pants_category)

  polo_content = 'A smooth and durable blend of cotton and recycled polyester. This wardrobe staple is always evolving.'
  create_product(index, 'Polo shirt', polo_content, 250000, 18, 'polo_shirt', polo_category)

  short_content = 'Quick-drying fabric that allows ease of movement. Versatile pants for relaxing at home or wearing out and about.'
  create_product(index, 'Short', short_content, 210000, 10, 'short', short_category)
end
