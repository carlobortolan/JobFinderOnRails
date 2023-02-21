class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table "locations", primary_key: "location_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.float "longitude", null: false
      t.float "latitude", null: false
      t.string "code_country", limit: 2
      t.string "administrative_area", limit: 45
      t.string "sub_administrative_area", limit: 45
      t.string "locality", limit: 45
      t.string "address", limit: 45
      t.string "postal_code", limit: 45
      t.string "premise", limit: 45
      t.timestamps
    end
  end
end
