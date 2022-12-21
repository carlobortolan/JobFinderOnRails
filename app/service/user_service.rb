# frozen_string_literal: true

class UserService
  def initialize
    @user_repository = UserRepository.new
  end

  def add_user(user)
    @user_repository.add_user(user)
    user.user_type.eql? "company" ? @user_repository.add_company(user) : @user_repository.add_private(user)
  end

  def remove_user(id)
    @user_repository.remove_user(id)
  end

  def find_user(id)
    @user_repository.find_user(id)
  end

  def find_all
    @user_repository.find_all
  end

end
