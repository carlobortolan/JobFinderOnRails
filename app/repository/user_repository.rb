# frozen_string_literal: true

class UserRepository
  # TODO:

  def get_user(user_id)
    if !user_id.nil? && user_id.is_a?(Integer)
      ActiveRecord::Base.connection.execute("SELECT * FROM accounts WHERE user_id = #{user_id}")
    end
  end

  def get_user_name(user_id)
    puts "user_id = #{user_id}"
    if !user_id.nil? && user_id.is_a?(Integer)
      ActiveRecord::Base.connection.execute("SELECT first_name, last_name FROM accounts WHERE account_id = #{user_id}").each do |i|
        return i.values_at("first_name")[0].to_s.concat(" #{i.values_at("last_name")[0].to_s}")
      end
    end
  end
end
