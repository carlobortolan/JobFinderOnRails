class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table "applications", primary_key: ["job_id", "applicant_id"], charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.integer "job_id", null: false
      t.integer "applicant_id", null: false
      t.datetime "applied_at", default: -> { DateTime.now }
      t.column "status", "enum('-1','0','1')", default: "0", null: false
      t.string "application_text", limit: 1000
      t.string "application_documents", limit: 100
      t.string "response", limit: 500
      t.index ["applicant_id"], name: "account_id_idx"
      t.index ["job_id", "applicant_id"], name: "index_applications_on_job_id_and_applicant_id", unique: true
    end
  end
end
