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

ActiveRecord::Schema[7.0].define(version: 202301100105555) do
  create_table "applications", primary_key: %w[job_id applicant_id], charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "applicant_id", null: false
    t.datetime "applied_at", null: false
    t.column "status", "enum('-1','0','1')", default: "0", null: false
    t.string "application_text", limit: 500
    t.string "application_documents", limit: 100
    t.string "response", limit: 500
    t.index ["applicant_id"], name: "account_id_idx"
    t.index %w[job_id applicant_id], name: "index_applications_on_job_id_and_applicant_id", unique: true
  end

  create_table "company_users", primary_key: "user_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "auth_blacklists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "token", limit: 500, null: false
    t.integer "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "token_UNIQUE", unique: true
  end

  create_table "authentications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "token", null: false
    t.integer "scope", null: false
    t.string "checksum", null: false
    t.integer "user", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.integer "view_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "job_information_account_id_idx"
  end

  create_table "locations", primary_key: "location_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "longitude", null: false
    t.float "latitude", null: false
    t.string "code_country", limit: 2
    t.string "administrative_area", limit: 45
    t.string "sub_administrative_area", limit: 45
    t.string "locality", limit: 45
    t.string "address", limit: 45
    t.string "postal_code", limit: 45
    t.string "premise", limit: 45
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", primary_key: %w[employer_id job_id], charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.integer "job_id", null: false
    t.column "notify", "enum(' 0',' 1')"
    t.index ["job_id"], name: "notification_job_id_idx"
  end

  create_table "private_users", primary_key: "user_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "private_attr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", primary_key: "user_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.column "rating", "enum('1','2','3','4','5')", null: false
    t.text "message"
    t.integer "created_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.references :user, null: false, foreign_key: true
    t.index ["created_by"], name: "fk_rails_50d2809d9b"
  end

  create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.integer "activity_status", limit: 1, default: 0, null: false
    t.string "image_url", limit: 500
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.float "longitude", null: false
    t.float "latitude", null: false
    t.string "country_code", limit: 45
    t.string "postal_code", limit: 45
    t.string "city", limit: 45
    t.string "address", limit: 45
    t.column "user_type", "enum('company','private')", default: "private", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "account_email_UNIQUE", unique: true
  end

  add_foreign_key "applications", "jobs", primary_key: "job_id"
  add_foreign_key "applications", "users", column: "applicant_id"
  add_foreign_key "company_users", "users"
  add_foreign_key "jobs", "users"
  add_foreign_key "notifications", "jobs", primary_key: "job_id"
  add_foreign_key "notifications", "users", column: "employer_id"
  add_foreign_key "private_users", "users"
  add_foreign_key "reviews", "users", column: "user_id"
  add_foreign_key "reviews", "users", column: "created_by"
end
