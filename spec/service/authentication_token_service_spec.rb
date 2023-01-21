require 'rails_helper'
require_relative '../../app/service/authentication_token_service.rb'

RSpec.describe AuthenticationTokenService::Refresh do
  #todo: make specific test for method which dont chtch exceptions to check for exceptions
  before :all do
    # populate db
    User.delete_all
    UserBlacklist.delete_all
    firsts = ["Carlo", "Jan", "Johannes", "Maximilian", "Xaver", "Fabian", "Simon", "Malte", "Lukas", "Moritz"]
    lasts = ["Bortolan", "Hummel", "Meier", "Müller", "Franz", "Maurer", "Schmidt", "Kaiser", "Bauer", "Metzger"]
    domains = ["gmail.com", "gmx.de", "arcor.com", "web.de", "outlook.com"]

    1000.times do
      first = firsts.sample
      last = lasts.sample
      domain = domains.sample
      mail = "#{first}.#{last}@#{domain}"
      pw = "abc"
      params = { "first_name" => first, "last_name" => last, "email" => mail, "password" => pw, "password_confirmation" => pw }
      user = User.new(params)
      if !user.save
        # puts user.errors.details
        # puts [first, last, domain, mail, pw]
        # puts "_____________________________________"
      end
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
    while (black_users < 5)
      user = User.all.where(activity_status: 1).sample
      black = UserBlacklist.new({ "user_id" => user.id })
      if black.save
        black_users = black_users + 1
      end
    end

    @valid_normal_inputs = []
    User.all.where(activity_status: 1).each do |c|
      unless UserBlacklist.find_by(user_id: c.id).present?
        @valid_normal_inputs.push(User.find_by(id: c.id))
      end
    end

  end
  # Todo: Write tests
  context "generating token with valid normal inputs" do
    describe '.call' do
      it 'returns a hash with {"token" => ...}' do
        @valid_normal_inputs.each do |user|
          token = described_class.call(user.id)
          expect(token).not_to be_nil
          expect(token.has_key?("token")).to be_truthy
        end
      end
    end

    describe '.content' do
      it 'returns a hash with{"token" => {...} ' do
        @valid_normal_inputs.each do |user|
          encoded_token = described_class.call(user.id)["token"]
          decoded_token = described_class.content(encoded_token)
          expect(decoded_token).not_to be_nil
          expect(decoded_token["token"]).to include("sub", "iat", "checksum", "jti", "exp", "iss")
          expect(decoded_token["token"]["sub"].to_i).to eq(user.id)
        end
      end
    end
  end

  context "generating token with valid abnormal inputs" do
    describe '.call' do
      it 'returns error message for inactivated user' do
        User.all.where(activity_status: 0).each do |c|
          token = described_class.call(c.id)
          expect(token).not_to be_nil
          expect(token.has_key?("error")).to be_truthy
          expect(token["error"]["errors"]["user"][0]["error"]).to eq("ERR_INACTIVE")
        end
      end

      it 'returns error message for activated blacklisted users' do
        cases = []
        User.all.where(activity_status: 1).each do |c|
          if UserBlacklist.find_by(user_id: c.id).present?
            cases.push(User.find_by(id: c.id))
          end
        end
        cases.each do |user|
          token = described_class.call(user.id)
          expect(token).not_to be_nil
          expect(token.has_key?("error")).to be_truthy
          expect(token["error"]["errors"]["user"][0]["error"]).to eq("ERR_BLOCKED")
        end
      end

      it 'returns error message for unknown users' do
        cases = []
        while (cases.length < 10)
          c = (1..((User.all.ids).to_a.min() - 1)).to_a.sample()
          if !User.find_by(id: c).present?
            cases.push(c)
          end
        end
        cases.each do |fake_user_id|
          token = described_class.call(fake_user_id)
          expect(token).not_to be_nil
          expect(token).to include("error")
          expect(token["error"]["errors"]["user"][0]["error"]).to eq("ERR_UNKNOWN")
        end
      end
    end

    describe '.content' do
      it 'returns error message for expired token' do
        2.times do
          # may be lifted to 10 or more if the tests get run not ever 10 secs XD
          encoded_token = described_class.call(@valid_normal_inputs.sample.id, 1)["token"]
          sleep(2)
          decoded_token = described_class.content(encoded_token)
          expect(decoded_token).not_to be_nil
          expect(decoded_token).to include("error")
          expect(decoded_token["error"]["errors"]["token"][0]["error"]).to eq("ERR_EXPIRED")
        end
      end
      it 'returns error message for invalid issuer' do

      end
      it 'returns error message if a token is blacklisted (if possible)' do

      end
      it 'returns error message for an invalid issued at timestamp' do

      end
      it 'returns error message if any required claim is missing' do

      end
      it 'returns error message for malformed token' do

      end
      it 'returns error message for checksum mismatches' do

      end
      it 'returns an array of messages for multiple errors' do

      end
    end

    describe '.decode' do
      it 'raises exception for expired token' do

      end
      it 'raises exception for invalid issuer' do

      end
      it 'raises exception for an invalid issued at timestamp' do

      end
      it 'raises exception if any required claim is missing' do

      end
      it 'raises exception for malformed token' do

      end
      it 'raises exception for checksum mismatches' do

      end

    end
  end

  context "generating token with invalid inputs" do
    it "drops exception if input either negative, nil or not an Integer" do
      cases = []
      10.times do
        cases.push(User.all.sample)
        cases.push(nil)
        cases.push((-10000000..-1).to_a.sample)
      end
      ["1", "2", "3", "4", "test", "5", "test2482", ""].each do |e|
        cases.push(e)
      end
      10.times do
        cases.shuffle!
      end
      cases.each do |malformed_input|
        expect { described_class.call(malformed_input) }.to raise_error(AuthenticationTokenService::InvalidInput)
      end
    end

  end

end
