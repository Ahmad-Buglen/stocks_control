class SupplyAdd
  def self.add(stock, product, count, view)
    s = Supply.new(:stock => stock, :product => product, :count => count, :view => view)
    begin
      if s.valid?
        Balance.transaction do
          s.save!
          balance = Balance.get(stock, product)
          Balance.create!(:stock => stock, :product => product, :count => balance + count)
        end
      else
        stock.errors.add(:add, "Error when adding to the database")
      end
    rescue StandardError
      stock.errors.add(:add, "Error when adding to the database")
    end
  end
end
