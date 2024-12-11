class CreateParameters < ActiveRecord::Migration[7.2]
  def change
    create_table :parameters do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
