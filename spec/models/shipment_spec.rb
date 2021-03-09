require 'rails_helper'

RSpec.describe Shipment, :type => :model do
  subject do
    described_class.new(:count => 10,
                        :view => 'sale',
                        :description => 'test',
                        :product_id => 1,
                        :stock_id => 1)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is valid without description' do
    subject.description = nil
    expect(subject).to be_valid
  end
  describe "Associations" do
    it { should belong_to(:stock).without_validating_presence }
    it { should belong_to(:product).without_validating_presence }
  end
  describe "Validations" do
    it { should validate_presence_of(:count) }
    it { should validate_presence_of(:view) }
  end
  describe ".sale" do
    it "create a new shipment" do
      product = Product.create(:name => "pear", :price => 77, :description => nil)
      stock = Stock.create(:name => "stock_1", :address => "m. Medvedkovo", :balance => 0)
      count_supply = 100
      Supply.add(stock, product, count_supply, 'supply')

      count_sale = 10
      before_stock_balance = stock.balance.to_i

      described_class.sale(stock, product, count_sale, 'sale')
      expect(stock.errors).to be_empty

      after_stock_balance = before_stock_balance + (count_sale * product.price.to_i)
      stock = Stock.find(stock.id)
      expect(stock.balance.to_i).to eq after_stock_balance

      after_product_on_stock = Balance.get(stock, product)
      expect(after_product_on_stock).to eq(count_supply - count_sale)

      described_class.sale(stock, product, 0, 'sale')
      expect(stock.errors[:sale].first).to eq "Error when adding to the database"

      described_class.sale(stock, product, 10, nil)
      expect(stock.errors[:sale].first).to eq "Error when adding to the database"
    end
  end

  describe ".transport" do
    it "product transportation " do
      product = Product.create(:name => "pear", :price => 77, :description => nil)
      stock_from = Stock.create(:name => "stock_1", :address => "m. Medvedkovo", :balance => 0)
      stock_where = Stock.create(:name => "stock_2", :address => "m. Cherkizovo", :balance => 0)
      count_supply = 100
      Supply.add(stock_from, product, count_supply, 'supply')
      before_product_on_stock_from = Balance.get(stock_from, product)
      before_product_on_stock_where = Balance.get(stock_where, product)
      count_transport = 10

      described_class.transport(stock_from, stock_where, product, count_transport, 'transport')
      expect(stock_from.errors).to be_empty

      after_product_on_stock_from = Balance.get(stock_from, product)
      expect(after_product_on_stock_from).to eq before_product_on_stock_from - count_transport

      after_product_on_stock_where = Balance.get(stock_where, product)
      expect(after_product_on_stock_where).to eq before_product_on_stock_where + count_transport

      described_class.transport(stock_from, stock_where, product, 0, 'transport')
      expect(stock_from.errors[:transport].first).to eq "Error when adding to the database"

      described_class.transport(stock_from, stock_where, product, 10, nil)
      expect(stock_from.errors[:transport].first).to eq "Error when adding to the database"
    end
  end
end
