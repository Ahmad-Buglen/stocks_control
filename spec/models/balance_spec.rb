require 'rails_helper'

RSpec.describe Balance, type: :model do
  describe "Associations" do
    it { should belong_to(:stock).without_validating_presence }
    it { should belong_to(:product).without_validating_presence }
  end
  describe "Validations" do
    it { should validate_presence_of(:count) }
  end
end
