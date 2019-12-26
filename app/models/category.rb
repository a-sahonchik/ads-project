# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :advertisements

  resourcify

  validates :name, presence: true,
                   length: { minimum: 3, maximum: 20 }

  def self.options_for_select
    categories = Category.arel_table
    order(categories[:name].lower).pluck(:name, :id)
  end
end
