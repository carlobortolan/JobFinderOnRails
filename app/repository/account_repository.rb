# frozen_string_literal: true

class AccountRepository
  def get_account(account_id)
    if !account_id.nil? && account_id.is_a?(Integer)
      ActiveRecord::Base.connection.query("SELECT * FROM accounts WHERE account_id = #{account_id}")
    end
  end

  def get_account_name(account_id)
    if !account_id.nil? && account_id.is_a?(Integer)
       ActiveRecord::Base.connection.query("SELECT first_name, last_name FROM accounts WHERE account_id = #{account_id}").each do |i|
         return i[0].to_s.concat(" #{i[1].to_s}")
       end
    end
  end
end
