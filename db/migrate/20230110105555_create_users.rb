class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "email", null: false
      t.string "password_digest"
      t.integer "activity_status", limit: 1, default: 0, null: false
      t.string "image_url", limit: 500
      t.string "first_name", null: false
      t.string "last_name", null: false
      # t.integer "location_id", default: 1, null: false
      t.float "longitude", null: false
      t.float "latitude", null: false
      t.string "country_code", limit: 45
      t.string "postal_code", limit: 45
      t.string "city", limit: 45
      t.string "address", limit: 45
      t.column "user_type", "enum('company','private')", default: "private", null: false

      t.index ["email"], name: "account_email_UNIQUE", unique: true
      # t.index ["location_id"], name: "fk_rails_5d96f79c2b"
      t.timestamps
    end
  end
end
