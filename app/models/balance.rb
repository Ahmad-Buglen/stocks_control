class Balance < ApplicationRecord
    belongs_to :stock
    belongs_to :product

    validates :count, presence: true

    def self.get(stock, product, time = Time.now)
        b = Balance.where(stock: stock, product: product).where("created_at < ?", time).last
        return b == nil ? 0 : b.count
    end
end
