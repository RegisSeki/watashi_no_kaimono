require 'rails_helper'

describe 'Categories Api', type: :request do
  let!(:user) { FactoryBot.create(:user, username: 'Yuki', password: 'thecat') }
  let!(:jwt) { AuthenticationService.encode_token(user.id) }

  describe 'POST /categories' do
    it 'create a new category' do
      expect {
        post '/api/v1/categories', params: {
          category: {
            name: 'Higiene Pessoal'
          }
        }, headers: { "Authorization" => "Bearer #{jwt}" }
      }.to change { Category.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          'id' => 1,
          'name' => 'Higiene Pessoal'
        }
      )
    end
  end

  describe 'GET /categories' do
    before do
      FactoryBot.create(:category, name: 'Limpeza')
      FactoryBot.create(:category, name: 'Alimentação')
    end

    it 'returns all categories' do
      get '/api/v1/categories'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
          'id' => 2,
          'name' => 'Limpeza'
          },
          {
            'id' => 3,
            'name' => 'Alimentação'
          }
        ]
      )
    end
  end

  describe 'DELETE /categories/:id' do
    let!(:category) { FactoryBot.create(:category, name: 'Alimentação') }

    it 'deletes a category' do
      expect {
        delete "/api/v1/categories/#{category.id}", headers: { "Authorization" => "Bearer #{jwt}" }
      }.to change { Category.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
