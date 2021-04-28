require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user) { FactoryBot.create(:user, username: 'Yuki', email: 'yuki@cat.com', password: 'thecat', password_confirmation: 'thecat') }
    let!(:jwt) { AuthenticationService.encode_token(user.id) }

    it 'authenticate the client' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'thecat' }

      expect(response).to have_http_status(:created)
      expect(response_body).to have_key('token')
    end

    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: 'thecat' }

      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq('Check your credentials')
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'Yuki' }

      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq('Check your credentials')
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'incorrect' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
