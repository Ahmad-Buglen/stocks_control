require 'rails_helper'

RSpec.describe Product, :type => :model do
  subject do
    described_class.new(:name => 'Apple',
                        :price => 99,
                        :description => 'some comment')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is valid without description' do
    subject.description = nil
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should have_many(:stocks).through(:supplies) }
    it { should have_many(:balances) }
    it { should have_many(:shipments) }
    it { should have_many(:supplies) }
  end
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
  end
end
