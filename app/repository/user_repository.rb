# frozen_string_literal: true
# TODO: Implement UserRepository
# TODO: ERROR CATCHING

class UserRepository
  def add_user(user)
    # ActiveRecord::Base.connection.execute("INSERT INTO users VALUES #{user}")
    query = "INSERT INTO users VALUES #{user}"
    binds = [ActiveRecord::Relation::QueryAttribute.new('user', user, ActiveRecord::Type::User.new)]
    ApplicationRecord.connection.exec_query(query, 'SQL', binds, prepare: true)
  end

  def find_user(user_id)
    # ActiveRecord::Base.connection.execute("SELECT * FROM users WHERE id = #{id};")
    query = "SELECT * FROM users WHERE user_id = #{user_id};"
    binds = [ActiveRecord::Relation::QueryAttribute.new('user_id', user_id, ActiveRecord::Type::Integer.new)]
    ApplicationRecord.connection.exec_query(query, 'SQL', binds, prepare: true)
  end

  def find_all_users
    ActiveRecord::Base.connection.execute("SELECT * FROM users;")
  end

  def delete_user(user_id)
    query = "REMOVE * FROM users WHERE user_id = #{user_id};"
    binds = [ActiveRecord::Relation::QueryAttribute.new('user_id', user_id, ActiveRecord::Type::Integer.new)]
    ApplicationRecord.connection.exec_query(query, 'SQL', binds, prepare: true)
  end
end
