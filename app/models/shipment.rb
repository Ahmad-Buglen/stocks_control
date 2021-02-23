class Shipment < ApplicationRecord
  belongs_to :stock
  belongs_to :product

  validates :count, :view, :presence => true
  validates :count, :numericality => { :greater_than_or_equal_to => 1 }

  def self.sale(stock, product, count, view)
    ShipmentOperation.sale(stock, product, count, view)
  end

  def self.transport(stock_from, stock_where, product, count, view)
    ShipmentOperation.transport(stock_from, stock_where, product, count, view)
  end
end
