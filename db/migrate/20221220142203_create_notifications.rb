class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table "notifications", primary_key: ["employer_id", "job_id"], charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.integer "employer_id", null: false
      t.integer "job_id", null: false
      t.column "notify", "enum('0','1')"
      t.index ["job_id"], name: "notification_job_id_idx"
    end
  # add_foreign_key "notifications", "accounts", column: "employer_id", primary_key: "account_id", name: "notification_employer_id", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "notifications", "jobs", primary_key: "job_id", name: "notification_job_id", on_update: :cascade, on_delete: :cascade
  end
end
