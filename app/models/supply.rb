class Supply < ApplicationRecord
  belongs_to :stock
  belongs_to :product

  validates :count, :view, :presence => true
  validates :count, :numericality => { :greater_than_or_equal_to => 1 }

  def self.add(stock, product, count, view)
    SupplyAdd.add(stock, product, count, view)
  end

end
