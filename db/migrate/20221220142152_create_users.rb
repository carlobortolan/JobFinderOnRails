class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "email", null: false
      t.string "password_digest"
      t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, null: false
      t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, null: false
      t.integer "activity_status", limit: 1, default: 0, null: false
      t.string "image_url", limit: 500
      t.string "first_name", null: false
      t.string "last_name", null: false
      t.index ["email"], name: "account_email_UNIQUE", unique: true
    end
  end
end
