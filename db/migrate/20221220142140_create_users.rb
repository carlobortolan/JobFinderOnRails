class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table "users", primary_key: "user_id", id: :integer, default: nil, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "code_nationality", limit: 2, null: false
      t.integer "location_id", default: 0
      t.column "user_type", "enum('private','company')", default: "private", null: false
      t.index ["location_id"], name: "location_id_idx"
    end
  # add_foreign_key "users", "accounts", column: "user_id", primary_key: "account_id", name: "user_account_id", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "users", "locations", primary_key: "location_id", name: "user_location_id", on_update: :cascade
end
end
