class Stock < ApplicationRecord
    has_many :supplies, dependent: :destroy
    has_many :balances, dependent: :destroy
    has_many :shipments, dependent: :destroy
    has_many :products, through: :supplies, dependent: :destroy

    validates :name, :address, :balance, presence: true
end
