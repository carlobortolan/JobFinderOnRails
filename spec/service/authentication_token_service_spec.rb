require 'rails_helper'
require_relative '../../app/service/authentication_token_service.rb'

RSpec.describe AuthenticationTokenService::Refresh do
  random_user = User.count
    #User.offset(rand(User.count)).first
  puts "RANDOM USER"
  p random_user
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

