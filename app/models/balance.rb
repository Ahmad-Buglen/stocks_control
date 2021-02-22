class Balance < ApplicationRecord
    belongs_to :stock
    belongs_to :product

    validates :count, presence: true
    validates :count, :numericality => { :greater_than_or_equal_to => 0 }

    def self.get(stock, product, time = Time.now)
        b = Balance.where(stock: stock, product: product).where("created_at < ?", time).last
        b == nil ? 0 : b.count
    end
end
