class ShipmentOperation
  def self.sale(stock, product, count, view)
    balance = Balance.get(stock, product)
    begin
      if !balance.nil? && (count <= balance) && (view == 'sale')
        Stock.transaction do
          get(stock, product, count, view, balance)
          s = Stock.find(stock.id)
          p = Product.find(product.id)
          s.balance = s.balance + (p.price * count)
          s.save!
        end
      else
        stock.errors.add(:sale, "Error when adding to the database")
      end
    rescue StandardError
      stock.errors.add(:sale, "Error when adding to the database")
    end
  end

  def self.transport(stock_from, stock_where, product, count, view)
    balance = Balance.get(stock_from, product)
    begin
      if !balance.nil? && (count <= balance) && (view == 'transport')
        Supply.transaction do
          get(stock_from, product, count, view, balance)
          Supply.add(stock_where, product, count, view)
        end
      else
        stock_from.errors.add(:transport, "Error when adding to the database")
      end
    rescue StandardError
      stock_from.errors.add(:transport, "Error when adding to the database")
    end
  end

  def self.get(stock, product, count, view, balance)
    Shipment.create!(:stock => stock, :product => product, :count => count, :view => view)
    Balance.create!(:stock => stock, :product => product, :count => balance - count)
  end
end
