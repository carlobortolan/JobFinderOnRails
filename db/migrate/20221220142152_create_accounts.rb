class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table "accounts", primary_key: "account_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "email", limit: 45, null: false
      t.string "password", limit: 45, null: false
      t.datetime "registration_date", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
      t.integer "activity_status", limit: 1, default: 0, null: false
      t.string "image_url", limit: 500
      t.string "first_name"
      t.string "last_name"
      t.index ["email"], name: "account_email_UNIQUE", unique: true
    end
  end
end
