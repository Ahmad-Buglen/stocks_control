class Product < ApplicationRecord
    has_many :supplies
    has_many :stocks, through: :supplies

    validates :name, :price, presence: true
end
