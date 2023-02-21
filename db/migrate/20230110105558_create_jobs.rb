class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table "jobs", primary_key: "job_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.column "job_type", "enum('typa','typb','typc')"
      t.integer "job_status", limit: 1, default: 0
      t.string "status", default: "0"
      t.integer "user_id", default: 0
      t.integer "duration", default: 0
      t.string "code_lang", limit: 2
      t.string "title", limit: 100
      t.text "description"
      t.integer "salary"
      t.column "currency", "enum('eur','usd','chf','gbp')"
      t.string "image_url", limit: 500
      t.datetime "start_slot", precision: nil
      t.float "longitude", null: false
      t.float "latitude", null: false
      # t.integer "location_id", default: 0, null: false
      t.integer "view_count", default: 0
      t.timestamps
      t.index ["location_id"], name: "fk_rails_e1588fa548"
      t.index ["user_id"], name: "job_information_account_id_idx"
    end
  end
end
