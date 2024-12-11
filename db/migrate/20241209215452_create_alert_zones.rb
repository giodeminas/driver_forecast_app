class CreateAlertZones < ActiveRecord::Migration[7.2]
  def change
    create_table :alert_zones do |t|
      t.references :alert, null: false, foreign_key: true
      t.string :name
      t.geometry :geometry, geographic: true, srid: 4326

      t.timestamps
    end
  end
end
