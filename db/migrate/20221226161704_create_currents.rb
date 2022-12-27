class CreateCurrents < ActiveRecord::Migration[7.0]
  def change
    create_table "currents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
      t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    end
  end
end
