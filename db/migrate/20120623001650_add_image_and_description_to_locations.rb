class AddImageAndDescriptionToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :image, :string
    add_column :locations, :description, :string
  end
end
