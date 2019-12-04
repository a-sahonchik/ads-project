class Category < ApplicationRecord
  has_many :advertisements
  validates :name, presence: true,
            length: { minimum: 3 , maximum: 20}
end
