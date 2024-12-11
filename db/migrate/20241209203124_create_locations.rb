class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :latitude
      t.string :longitude
      t.string :state

      t.timestamps
    end
  end
end
