# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


banana = Product.create(name: 'banana', price: 99)
apple = Product.create(name: 'apple', price: 111)
pear = Product.create(name: 'pear', price: 77)

stock_1 = Stock.create(name: 'stock_1', address: 'm. Medvedkovo', balance: 0)
stock_2 = Stock.create(name: 'stock_2', address: 'm. Novokosino', balance: 0)
stock_3 = Stock.create(name: 'stock_3', address: 'm. Domodedovo', balance: 0)

Supply.add(stock_1, banana, 50, 'supply')
Supply.add(stock_1, apple, 50, 'supply')
Supply.add(stock_1, pear, 50, 'supply')
Supply.add(stock_2, banana, 50, 'supply')
Supply.add(stock_2, apple, 50, 'supply')
Supply.add(stock_2, pear, 50, 'supply')
Supply.add(stock_3, banana, 50, 'supply')
Supply.add(stock_3, apple, 50, 'supply')
Supply.add(stock_3, pear, 50, 'supply')

Shipment.sale(stock_1, banana, 10, 'sale')
Shipment.sale(stock_2, banana, 10, 'sale')
Shipment.sale(stock_3, banana, 10, 'sale')
Shipment.sale(stock_1, apple, 10, 'sale')
Shipment.sale(stock_2, apple, 10, 'sale')
Shipment.sale(stock_3, apple, 10, 'sale')
Shipment.sale(stock_1, pear, 10, 'sale')
Shipment.sale(stock_2, pear, 10, 'sale')
Shipment.sale(stock_3, pear, 10, 'sale')

Shipment.transport(stock_1, stock_2, banana, 5, 'transport')
Shipment.transport(stock_2, stock_3, apple, 5, 'transport')
Shipment.transport(stock_3, stock_1, pear, 5, 'transport')
