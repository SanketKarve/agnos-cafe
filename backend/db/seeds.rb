# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

unless Customer.exists?
  puts 'Create customers'
  5.times do
    Customer.create(name: Faker::Name.name, phone_number: Faker::PhoneNumber.cell_phone_in_e164)
  end
  puts "#{Customer.count} Customer created."
end

unless Product.exists?
  puts 'Create products'
  20.times do
    Product.create(
      title: Faker::Food.dish,
      description: Faker::Food.description,
      price: Faker::Number.between(from: 10, to: 100),
      quantity: Faker::Number.between(from: 10, to: 20)
    )
  end
  puts "#{Product.count} Product created."
end

unless Tax.exists?
  puts 'Create taxes'
  5.times do
    current_date = DateTime.now
    Tax.create(
      name: Faker::Code.asin,
      percent: Faker::Number.between(from: 5, to: 20),
      start_date: current_date,
      end_date: (current_date + 30).to_s
    )
  end
  puts "#{Tax.count} Tax created."
end

unless TaxGroup.exists?
  puts 'Create TaxGroups'
  5.times do
    t = TaxGroup.create
    rand(1..5).times do
      t.products << Product.find(rand(1..20)).id
    end
    t.tax = Tax.order('RANDOM()').first
    t.save!
  end
  puts "#{TaxGroup.count} TaxGroup created."
end

unless Purchase.exists?
  puts 'Create Purchases'
  Customer.all.each do |customer|
    order = Order.create(customer: customer)
    rand(1..5).times do
      Purchase.create(
        order: order,
        customer: customer,
        product: Product.find(Faker::Number.between(from: 1, to: 20)),
        quantity: Faker::Number.between(from: 1, to: 5)
      )
    end
    order.total_price = Faker::Number.between(from: 10, to: 200)
    order.tax_price = Faker::Number.between(from: 10, to: 20)
    order.net_price = order.total_price - order.tax_price
    order.save!
  end
  puts "#{Purchase.count} Purchase created."
  puts "#{Order.count} Order created."
end
