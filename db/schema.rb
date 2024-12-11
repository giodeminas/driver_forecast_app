# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_10_180522) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "alert_zones", force: :cascade do |t|
    t.bigint "alert_id", null: false
    t.string "name"
    t.geography "geometry", limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_alert_zones_on_alert_id"
  end

  create_table "alerts", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.string "area_desc"
    t.string "headline"
    t.text "description"
    t.text "instruction"
    t.string "effective"
    t.string "expires"
    t.string "severity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_desc", "headline", "description", "instruction", "effective", "expires", "severity"], name: "index_unique_alerts", unique: true
    t.index ["location_id"], name: "index_alerts_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "latitude"
    t.string "longitude"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parameters", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alert_zones", "alerts"
  add_foreign_key "alerts", "locations"
end
