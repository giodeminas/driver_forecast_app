class AddUniqueIndexToAlerts < ActiveRecord::Migration[7.2]
  def change
    add_index :alerts, [:area_desc, :headline, :description, :instruction, :effective, :expires, :severity], unique: true, name: 'index_unique_alerts'
  end
end
