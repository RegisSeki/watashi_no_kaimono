require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user) { FactoryBot.create(:user, username: 'Yuki', password: 'thecat') }
    let!(:jwt) { AuthenticationService.encode_token(user.id) }

    it 'authenticate the client' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'thecat' }

      expect(response).to have_http_status(:created)
      expect(response_body).to have_key('token')
    end

    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: 'thecat' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: username'
      })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'Yuki' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'incorrect' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
