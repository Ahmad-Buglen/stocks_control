class Product < ApplicationRecord
    has_many :supplies, dependent: :destroy
    has_many :balances, dependent: :destroy
    has_many :shipments, dependent: :destroy
    has_many :stocks, through: :supplies, dependent: :destroy

    validates :name, :price, presence: true
end
