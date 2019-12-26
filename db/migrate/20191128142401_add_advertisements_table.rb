# frozen_string_literal: true

class AddAdvertisementsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :advertisements do |t|
      t.string :ad_title
      t.text :ad_text

      t.timestamps
    end
  end
end
