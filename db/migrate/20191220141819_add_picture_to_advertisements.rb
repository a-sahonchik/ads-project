class AddPictureToAdvertisements < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :picture, :string
  end
end
