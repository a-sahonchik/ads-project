# frozen_string_literal: true

class ChangePictureToPicturesForAdvertisements < ActiveRecord::Migration[5.2]
  def change
    rename_column :advertisements, :picture, :pictures
  end
end
