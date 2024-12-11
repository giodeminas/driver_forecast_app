class CreateAlerts < ActiveRecord::Migration[7.2]
  def change
    create_table :alerts do |t|
      t.references :location, null: false, foreign_key: true
      t.string :area_desc
      t.string :headline
      t.text :description
      t.text :instruction
      t.string :effective
      t.string :expires
      t.string :severity

      t.timestamps
    end
  end
end
