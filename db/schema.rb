# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_26_220845) do
  create_table "applications", primary_key: ["job_id", "applicant_id"], charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "applicant_id", null: false
    t.datetime "applied_at", precision: nil, default: "2022-12-27 18:22:29", null: false
    t.column "status", "enum('-1','0','1')", default: "0", null: false
    t.string "application_text", limit: 500
    t.string "application_documents", limit: 100
    t.string "response", limit: 500
    t.index ["applicant_id"], name: "account_id_idx"
    t.index ["job_id", "applicant_id"], name: "index_applications_on_job_id_and_applicant_id", unique: true
  end

  create_table "currents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", default: "2022-12-27 18:22:29", null: false
    t.datetime "updated_at", default: "2022-12-27 18:22:29", null: false
  end

  create_table "jobs", primary_key: "job_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.column "job_type", "enum('typa','typb','typc')"
    t.integer "job_status", limit: 1, default: 0
    t.string "status", default: "0"
    t.datetime "created_at", default: "2022-12-27 18:22:29", null: false
    t.datetime "updated_at", default: "2022-12-27 18:22:29", null: false
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

  create_table "locations", primary_key: "location_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "code_country", limit: 2, null: false
    t.string "administrative_area", limit: 45
    t.string "sub_administrative_area", limit: 45
    t.string "locality", limit: 45, null: false
    t.string "address", limit: 45, null: false
    t.string "postal_code", limit: 45, null: false
    t.string "premise", limit: 45
    t.datetime "date_location_creation", default: "2022-12-27 18:22:29", null: false
  end

  create_table "notifications", primary_key: ["employer_id", "job_id"], charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.integer "job_id", null: false
    t.column "notify", "enum('0','1')"
    t.index ["job_id"], name: "notification_job_id_idx"
  end

  create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", default: "2022-12-27 18:22:29", null: false
    t.datetime "updated_at", default: "2022-12-27 18:22:29", null: false
    t.integer "activity_status", limit: 1, default: 0, null: false
    t.string "image_url", limit: 500
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.index ["email"], name: "account_email_UNIQUE", unique: true
  end

  add_foreign_key "applications", "jobs", primary_key: "job_id"
  add_foreign_key "applications", "users", column: "applicant_id"
  add_foreign_key "jobs", "users"
  add_foreign_key "notifications", "jobs", primary_key: "job_id"
  add_foreign_key "notifications", "users", column: "employer_id"
end
