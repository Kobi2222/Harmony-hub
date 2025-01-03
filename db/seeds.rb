# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Create categories
categories = Category.create([
  { name: 'Instruments' },
  { name: 'Vinyl Records' },
  { name: 'Accessories' }
])

# Create products associated with categories
categories.each do |category|
  10.times do |i|
    Product.create(
      name: "Product #{i + 1} in #{category.name}",
      description: "Description of Product #{i + 1} in #{category.name}",
      price: rand(50..200),
      stock_quantity: rand(5..50),
      category: category
    )
  end
end

about_content_data = {
  content: "Harmony Hub is an e-commerce platform dedicated to serving the vibrant community of music enthusiasts. Our mission is to provide a one-stop-shop where music lovers can explore, discover, and purchase products that resonate with their musical journey."
}

# Seed data for Contact content
contact_content_data = {
  content: "For any inquiries or assistance, feel free to contact us at support@harmonyhub.com."
}

# Create or update AboutContent record
about_content = AboutContent.first_or_initialize
about_content.update(about_content_data)

# Create or update ContactContent record
contact_content = ContactContent.first_or_initialize
contact_content.update(contact_content_data)
