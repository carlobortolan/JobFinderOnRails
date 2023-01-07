class CreateAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :authentications do |t|
      t.string :token, null: false, limit:500
      t.integer :scope, null: false
      t.integer :user, null: false
      t.datetime :expires_at, null: false
      t.string :issuer, null: false
      t.timestamps
    end
  end
end
