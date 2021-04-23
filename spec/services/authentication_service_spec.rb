require 'rails_helper'

describe AuthenticationService do
  describe '.encode_token' do
    let(:user) { FactoryBot.create(:user, username: 'Yuki', password: 'thecat') }
    let(:token) { described_class.encode_token(user.id) }

    it 'returns an authentication token' do
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )

      expect(decoded_token.first).to have_key('id')
      expect(decoded_token.first).to have_key('date')
      expect(decoded_token.last).to eq ({"alg"=>"HS256"})
    end
  end

  describe '.authenticate_token' do
    let!(:user) { FactoryBot.create(:user, username: 'Yuki', password: 'thecat') }
    let!(:token) { described_class.encode_token(user.id) }

    it 'raise when token date is expired' do
      Timecop.travel(1.days)
      expect { described_class.authenticate_token(token) }.to raise_error('Token date is not valid!')
    end
  end
end
