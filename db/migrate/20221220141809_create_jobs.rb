class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table "jobs", primary_key: "job_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.column "job_type", "enum('typa','typb','typc')"
      t.integer "job_status", limit: 1, default: 0
      t.string "status", default: "0"
      t.datetime "created_at", default: DateTime.now, null: false
      t.datetime "updated_at", default: DateTime.now, null: false
      t.integer "user_id", default: 0
      t.float "latitude", default: 0.0
      t.float "longitude", default: 0.0
      t.integer "duration", default: 0
      t.string "code_lang", limit: 2
      t.string "title", limit: 100
      t.text "description"
      t.integer "salary"
      t.column "currency", "enum('eur','usd','chf','gbp')"
      t.string "image_url", limit: 500
      t.datetime "start_slot", precision: nil
      t.string "time_zone", limit: 45
      t.integer "application_count", default: 0
      t.integer "view_count", default: 0
      t.integer "favorite_count", default: 0
      t.index ["longitude", "latitude"], name: "job_information_location_id_idx"
      t.index ["user_id"], name: "job_information_account_id_idx"
    end
    # add_foreign_key "jobs", "accounts", primary_key: "account_id", name: "job_account_id", on_update: :cascade, on_delete: :cascade
    # add_foreign_key "jobs", "locations", primary_key: "location_id", name: "job_location_id", on_update: :cascade
  end
end
