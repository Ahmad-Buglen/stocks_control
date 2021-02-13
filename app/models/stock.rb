class Stock < ApplicationRecord
    has_many :supplies
    has_many :products, through: :supplies

    validates :name, :address, :balance, presence: true
end
