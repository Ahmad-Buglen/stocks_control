require 'rails_helper'

RSpec.describe Supply, :type => :model do
  describe "Associations" do
    it { should belong_to(:stock).without_validating_presence }
    it { should belong_to(:product).without_validating_presence }
  end
  describe "Validations" do
    it { should validate_presence_of(:count) }
    it { should validate_presence_of(:view) }
  end
  describe ".add" do
    it "create a new supply" do
      product = Product.create(:name => "pear", :price => 0.77e2, :description => nil)
      stock = Stock.create(:name => "stock_1", :address => "m. Medvedkovo", :balance => 0)

      count = 10
      balance = Balance.get(product, stock)

      described_class.add(stock, product, count, 'supply')
      expect(stock.errors).to be_empty
      balance_after = Balance.get(stock, product)
      expect(count).to eq balance_after

      described_class.add(stock, product, 0, 'supply')
      expect(stock.errors[:add].first).to eq "Error when adding to the database"

      described_class.add(stock, product, 10, nil)
      expect(stock.errors[:add].first).to eq "Error when adding to the database"
    end
  end
end
