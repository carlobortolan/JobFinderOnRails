require 'rails_helper'
require_relative '../../app/service/authentication_token_service.rb'

RSpec.describe AuthenticationTokenService::Refresh::Encoder do
  # todo: make specific test for method which dont chtch exceptions to check for exceptions
  before :all do
    # populate db
    User.delete_all
    UserBlacklist.delete_all
    firsts = ["Carlo", "Jan", "Johannes", "Maximilian", "Xaver", "Fabian", "Simon", "Malte", "Lukas", "Moritz"]
    lasts = ["Bortolan", "Hummel", "Meier", "Müller", "Franz", "Maurer", "Schmidt", "Kaiser", "Bauer", "Metzger"]
    domains = ["gmail.com", "gmx.de", "arcor.com", "web.de", "outlook.com"]

    500.times do
      first = firsts.sample
      last = lasts.sample
      domain = domains.sample
      mail = "#{first}.#{last}@#{domain}"
      pw = "abc"
      params = { "first_name" => first, "last_name" => last, "email" => mail, "password" => pw, "password_confirmation" => pw }
      User.new(params).save
    end
    # adapt
    half = ((User.all.count) / 2).to_i
    active_users = 0
    while (active_users < half)
      user = User.all.sample
      if user.activity_status == 0
        user.update(activity_status: 1)
        active_users = active_users + 1
      end
    end

    black_users = 0
    @valid_blocked_users = []
    while (black_users < 5)
      user = User.all.where(activity_status: 1).sample
      black = UserBlacklist.new({ "user_id" => user.id })
      if black.save
        @valid_blocked_users.push(user)
        black_users = black_users + 1
      end
    end

    @valid_normal_inputs = []
    User.all.where(activity_status: 1).each do |c|
      unless UserBlacklist.find_by(user_id: c.id).present?
        @valid_normal_inputs.push(User.find_by(id: c.id))
      end
    end

    @valid_inactive_users = User.all.where(activity_status: 0).to_a

    @valid_unknown_users = []
    unknowns = (1..User.all.ids.to_a.min - 1).to_a

    while (@valid_unknown_users.length != 100)
      @valid_unknown_users.push(unknowns.sample)
      @valid_unknown_users.uniq!
    end

    @invalid_user_ids = []
    20.times do
      @invalid_user_ids.push(User.all.sample)
      @invalid_user_ids.push(nil)
      @invalid_user_ids.push((-10000000..-1).to_a.sample)
    end
    [0, "1", "2", "3", "4", "test", "5", "test2482", "", [], {}].each do |e|
      @invalid_user_ids.push(e)
    end
    len = @invalid_user_ids.length
    while (@invalid_user_ids.length <= len + 50) do
      @invalid_user_ids.push(@valid_normal_inputs.sample)
      @invalid_user_ids.uniq!
    end

    50.times do
      @invalid_user_ids.shuffle!
    end
  end

  context 'valid normal users' do
    describe '.call' do
      it 'does not throw exceptions without a manual interval parameter given' do
        @valid_normal_inputs.each do |user|
          expect {
            described_class.call(user.id)
          }.not_to raise_error
        end
      end
      it 'does not throw exceptions with a manual interval parameter given' do
        @valid_normal_inputs.each do |user|
          man_interval = (1800..86400).to_a.sample
          expect {
            described_class.call(user.id, man_interval)
          }.not_to raise_error
        end
      end

      it 'returns a string without a manual interval parameter given' do
        @valid_normal_inputs.each do |user|
          expect(described_class.call(user.id)).to be_a String
        end
      end
      it 'returns a string with a manual interval parameter given' do
        @valid_normal_inputs.each do |user|
          man_interval = (1800..86400).to_a.sample
          expect(described_class.call(user.id, man_interval)).to be_a String
        end
      end
    end

  end

  context 'valid abnormal users' do
    describe '.call' do
      it 'throws exception for an user id not represented in the db' do
        @valid_unknown_users.each do |id|
          expect {
            described_class.call(id)
          }.to raise_error(AuthenticationTokenService::InvalidUser::Unknown)
        end
      end
      it 'throws exception for an existing user who\'s activity status is 0/inactive' do
        @valid_inactive_users.each do |user|
          expect {
            described_class.call(user.id)
          }.to raise_error(AuthenticationTokenService::InvalidUser::Inactive::NotVerified)
        end
      end
      it 'throws exception for an existing active user who is listed on the user blacklist (and so is blocked)' do
        @valid_blocked_users.each do |user|
          expect {
            described_class.call(user.id)
          }.to raise_error(AuthenticationTokenService::InvalidUser::Inactive::Blocked)
        end
      end
      it 'does not throw exceptions for a to large or to small valid manual interval parameter given' do
        alt = -1
        @valid_normal_inputs.each do |user|
          if alt.negative?
            man_interval = (1..1799).to_a.sample
          else
            man_interval = (86401..88000).to_a.sample
          end
          puts man_interval
          alt = alt * (-1)
          expect(described_class.call(user.id, man_interval)).to be_a String
        end

      end
    end
  end

  context 'invalid users' do
    describe '.call' do
      it 'throws exception for non-Integers and non-positive-Integers as the user_id parameter' do
        @invalid_user_ids.each do |id|
          expect {
            described_class.call(id)
          }.to raise_error(AuthenticationTokenService::InvalidInput)
        end
      end

      it 'throws exceptions for non-Integers and non positive-Integers as the manual interval parameter for valid normal users' do
        @invalid_user_ids.each do |man_interval|
          expect {
            described_class.call(@valid_normal_inputs.sample,man_interval)
          }.to raise_error(AuthenticationTokenService::InvalidInput)
        end
      end

    end
  end
end