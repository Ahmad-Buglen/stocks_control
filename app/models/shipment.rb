class Shipment < ApplicationRecord
    belongs_to :stock
    belongs_to :product

    validates :count, :view, presence: true
    validates :count, :numericality => { greater_than_or_equal_to: 1 }

    def self.sale(stock, product, count, view)
        balance = Balance.get(stock, product)
        begin
            if ((balance != nil) && (count <= balance) && (view == 'sale'))
                ActiveRecord::Base.transaction do
                    get(stock, product, count, view, balance)
                    s = Stock.find(stock.id)
                    p = Product.find(product.id)
                    s.balance = s.balance + (p.price * count)
                    s.save!
                end
            end
        rescue
            puts 'Error when adding to the database'
        end
    end

    def self.transport(stock_from, stock_where, product, count, view)
        balance = Balance.get(stock_from, product)
        begin
            if ((balance != nil) && (count <= balance) && (view == 'transport'))
                ActiveRecord::Base.transaction do
                    get(stock_from, product, count, view, balance)
                    Supply.add(stock_where, product, count, view)
                end
            end
        rescue
            puts 'Error when adding to the database'
        end
    end

    private

    def self.get(stock, product, count, view, balance)
        Shipment.create!(stock: stock, product: product, count: count, view: view)
        Balance.create!(stock: stock, product: product, count: balance - count)
    end
end
