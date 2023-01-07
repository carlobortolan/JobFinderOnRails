class CreateAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :authentications do |t|
      t.string :token, null: false
      t.integer :scope, null: false
      t.string :checksum, null: false
      t.integer :user, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
