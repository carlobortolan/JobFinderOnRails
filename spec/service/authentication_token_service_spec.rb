require 'rails_helper'
require_relative '../../app/service/authentication_token_service.rb'

RSpec.describe AuthenticationTokenService::Refresh do
  before :all do
    # populate db
    User.delete_all
    UserBlacklist.delete_all
    firsts = ["Carlo", "Jan"]
    lasts = ["Bortolan", "Hummel"]
    domains = ["gmail.com", "gmx.de"]

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
    while (black_users < 1)
      user = User.all.where(activity_status: 1).sample
      black = UserBlacklist.new({"user_id" => user.id})
      if black.save
        puts "LISTED"
        black_users = black_users + 1
      end
    end


  end
  # Todo: Write tests
  context "generating token with valid normal inputs" do
    describe '.call' do
      it 'returns nothing' do
        cases = []
        User.all.where(activity_status: 1).each do |c|
          unless UserBlacklist.find_by(user_id: c.id).present?
            cases.push(User.find_by(id: c.id))
          end
        end

        cases.each do |user|
          puts described_class.call(user.id)
        end
      end
    end
    describe '.hi' do
      it 'returns a hi' do
        expect(described_class.hi).to eq("hi")
      end
    end
  end

end

# RSpec.describe AuthenticationTokenService do
#  describe '.call' do
#    let(:token) {described_class.call( Socket.gethostname, 56, "2023-12-31 23:59:59 +0200")}
#    it 'returns an authentication token' do
#      decoded_token = JWT.decode(
#        token,
#        described_class::HMAC_SECRET,
#        true,
#        { algorithm: described_class::ALGORITHM_TYPE }
#      )
#
#      expect(decoded_token).to eq(
#                                 [
#                                   { "user_id" => 56 },
#                                  { "alg" => "HS256" }
#                                 ]
#                              )
#
#   end
# end

