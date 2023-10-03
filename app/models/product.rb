class Product < ApplicationRecord

    ORDER_BY = {
        newest: "created_at DESC",
        expensive: "price DESC",
        cheapest: "price ASC"
    }

    has_one_attached :photo

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    belongs_to :category
end
