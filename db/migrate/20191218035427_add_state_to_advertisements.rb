# frozen_string_literal: true

class AddStateToAdvertisements < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :state, :string
    add_index :advertisements, :state
  end
end
