class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table "locations", primary_key: "location_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.float "latitude"
      t.float "longitude"
      t.string "code_country", limit: 2, null: false
      t.string "administrative_area", limit: 45
      t.string "sub_administrative_area", limit: 45
      t.string "locality", limit: 45, null: false
      t.string "address", limit: 45, null: false
      t.string "postal_code", limit: 45, null: false
      t.string "premise", limit: 45
      t.datetime "date_location_creation", default: -> { "CURRENT_TIMESTAMP" }, null: false
    end
  end
end
