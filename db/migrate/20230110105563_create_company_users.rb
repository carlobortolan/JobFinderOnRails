class CreatePrivateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :private_users do |t|
      t.string "company_name"
      t.timestamps
    end
  end
end
