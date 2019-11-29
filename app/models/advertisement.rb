class Advertisement < ApplicationRecord
  validates :ad_title, presence: true,
                    length: { minimum: 5 , maximum: 50}
  validates :ad_text, presence: true,
                    length: { minimum: 100 , maximum: 1000}
end
