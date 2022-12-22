# frozen_string_literal: true

class AccountService
  def initialize
    @account_repository = AccountRepository.new
  end

  def get_account_name(account_id)
    if !account_id.nil? && account_id.is_a?(Integer)
      @account_repository.get_account_name(account_id)
    end
  end
end
