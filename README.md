# README

## Installation
1. Run `bundle install`
2. Run `rake db:create`
3. Run `rake db:migrate`
4. Run `rake db:seed`
5. Start a server `rails s`


## Description

Завоз товара(product) на склад(stock) в указанном количестве(count).
```
Supply.add(stock, product, count, view)
```

Получение остатков на складе(stock) по продукту(product). По умолчанию на данный момент.
```
Balance.get(stock, product, time = Time.now)
```

Продажа товара со склада(view = 'sale').
```
Shipment.sale(stock, product, count, view)
```

Перевозка со склада на склад(view = 'transport').
```
Shipment.transport(stock_from, stock_where, product, count, view)
```

'stock.balance' - баланс склада.
