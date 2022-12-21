# frozen_string_literal: true

class UserRepository
  def initialize
    @client = Mysql2::Client.new(host: "localhost", port: "3306", database: "masterdata_2", username: "rm_user", password: "hô[ÕiÚéjÚ¢X*t/t¢ÕeR/ü¾nõ'g'ñ¢ß«Tíwàx²\"¡jÛß´*PZÏmõ}ßX¨º*¤àÙ7ü'ÌJÌ=´Lh#M[NöèD`¿üåvã^àði®$4¦{·d3ZE~üMêr.7>þSrÖô(òúHÒDÊ]!Ä-¯.ï!òHúã¡")
  end

  # TODO:

  def get_user(user_id)
    if !user_id.nil? && user_id.is_a?(Integer)
      @client.query("SELECT * FROM accounts WHERE user_id = #{user_id}")
    end
  end

  def get_user_name(user_id)
    puts "user_id = #{user_id}"
    if !user_id.nil? && user_id.is_a?(Integer)
      @client.query("SELECT first_name, last_name FROM accounts WHERE account_id = #{user_id}").each do |i|
        return i.values_at("first_name")[0].to_s.concat(" #{i.values_at("last_name")[0].to_s}")
      end
    end
  end
end
