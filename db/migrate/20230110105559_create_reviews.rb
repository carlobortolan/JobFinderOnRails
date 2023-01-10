class CreateReviews < ActiveRecord::Migration[7.0]
  create_table "reviews", primary_key: "user_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.column "rating", "enum('1','2','3','4','5')", null: false
    t.text "message"
    t.integer "created_by", null: false
    t.timestamps
    t.index ["created_by"], name: "fk_rails_50d2809d9b"
  end

end
