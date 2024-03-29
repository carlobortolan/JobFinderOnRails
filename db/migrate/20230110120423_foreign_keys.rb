class ForeignKeys < ActiveRecord::Migration[7.0]
  def change
    execute("SET FOREIGN_KEY_CHECKS=0;")
    #  add_foreign_key :users, :locations, column: :location_id, primary_key: :location_id
    add_foreign_key :private_users, :users, column: :user_id, primary_key: :id
    add_foreign_key :company_users, :users, column: :user_id, primary_key: :id

    add_foreign_key :jobs, :users, column: :user_id, primary_key: :id
    # add_foreign_key :jobs, :locations, column: :location_id, primary_key: :location_id

    add_foreign_key :applications, :users, column: :applicant_id, primary_key: :id
    add_foreign_key :applications, :jobs, column: :job_id, primary_key: :job_id

    add_foreign_key :notifications, :users, column: :employer_id, primary_key: :id
    add_foreign_key :notifications, :jobs, column: :job_id, primary_key: :job_id

    add_foreign_key :reviews, :users, column: :created_by, primary_key: :id
    execute("SET FOREIGN_KEY_CHECKS=1;")

  end
end
