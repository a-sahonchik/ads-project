# frozen_string_literal: true

class AddCategoryIdToAdvertisements < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :category_id, :integer
    add_index :advertisements, :category_id
  end
end
