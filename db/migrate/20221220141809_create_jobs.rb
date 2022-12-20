class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table "jobs", primary_key: "job_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.column "job_type", "enum('typa','typb','typc')", null: true
      t.integer "job_status", limit: 1, default: 0, null: true
      t.string "status", default: 0, null: true
      t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: true
      t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: true
      t.integer "account_id", default: 0, null: true
      t.integer "location_id", default: 0, null: true
      t.integer "duration", default: 0, null: true
      t.string "code_lang",limit: 2, null: true
      t.string "title", limit: 45, null: true
      t.string "description", limit: 500, null: true
      t.integer "salary", null: true
      t.column "currency", "enum('eur','usd','chf','gbp')", null: true
      t.string "image_url", limit: 500
      t.datetime "start_slot", precision: nil, null: true
      t.string "time_zone", limit: 45, null: true
      t.integer "application_count", default: 0, null: true
      t.integer "view_count", default: 0, null: true
      t.integer "favorite_count", default: 0, null: true
      t.index ["account_id"], name: "job_information_account_id_idx"
      t.index ["location_id"], name: "job_information_location_id_idx"
    end
    # add_foreign_key "jobs", "accounts", primary_key: "account_id", name: "job_account_id", on_update: :cascade, on_delete: :cascade
    # add_foreign_key "jobs", "locations", primary_key: "location_id", name: "job_location_id", on_update: :cascade
  end
end
