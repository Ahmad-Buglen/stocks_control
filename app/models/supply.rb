class Supply < ApplicationRecord
    belongs_to :stock
    belongs_to :product

    validates :count, :view, presence: true

    def self.add(stock, product, count, view)
        s = Supply.new(stock: stock, product: product, count: count, view: view)
        if s.valid?
            s.save
            balance = Balance.get(stock, product)
            Balance.create(stock: stock, product: product, count: balance + count)
        end
    end

end
