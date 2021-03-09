require 'rails_helper'

RSpec.describe Stock, :type => :model do
  subject do
    described_class.new(:name => 'South',
                        :address => 'Chertanovo',
                        :balance => 0)
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should have_many(:products).through(:supplies) }
    it { should have_many(:balances) }
    it { should have_many(:shipments) }
    it { should have_many(:supplies) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:balance) }
  end
end
