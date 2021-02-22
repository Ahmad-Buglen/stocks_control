class Supply < ApplicationRecord
    belongs_to :stock
    belongs_to :product

    validates :count, :view, presence: true
    validates :count, :numericality => { greater_than_or_equal_to: 1 }

    def self.add(stock, product, count, view)
        s = Supply.new(stock: stock, product: product, count: count, view: view)
        begin
            if s.valid?
                ActiveRecord::Base.transaction do
                    s.save!
                    balance = Balance.get(stock, product)
                    Balance.create!(stock: stock, product: product, count: balance + count)
                end
            end
        rescue
            puts 'Error when adding to the database'
        end
    end

end
