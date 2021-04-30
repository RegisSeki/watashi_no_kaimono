require 'rails_helper'

describe 'Categories Api', type: :request do
  let(:user) { FactoryBot.create(:user, username: 'Yuki', email: 'yuki@cat.com', password: 'thecat', password_confirmation: 'thecat') }
  let!(:jwt) { AuthenticationService.encode_token(user.id) }

  describe 'POST /categories' do
    it 'create a new category' do
      expect {
        post '/api/v1/categories', params: {
          category: {
            name: 'Higiene Pessoal',
            description: 'Produtos de Limpeza pessoal'
          }
        }, headers: { "Authorization" => "Bearer #{jwt}" }
      }.to change { Category.count }.from(0).to(1)

      created_category = Category.last
      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          'id' => created_category.id,
          'name' => 'Higiene Pessoal',
          'description' => 'Produtos de Limpeza pessoal'
        }
      )
    end
  end

  describe 'UPDATE /categories/:id' do
    let!(:category) { FactoryBot.create(:category, name: 'Limpeza', description: 'Produtos de Limpeza antigo') }

    it 'update a category description' do
      put "/api/v1/categories/#{category.id}", params: {
        category: {
          description: 'Produtos de Limpeza atualizado'
        }
      }, headers: { "Authorization" => "Bearer #{jwt}" }

      expect(response).to have_http_status(:ok)
      expect(response_body).to eq(
        {
          'id' => category.id,
          'name' => 'Limpeza',
          'description' => 'Produtos de Limpeza atualizado'
        }
      )
    end
  end

  describe 'GET /categories' do
    let!(:category_1) { FactoryBot.create(:category, name: 'Limpeza', description: 'Produtos de Limpeza') }
    let!(:category_2) { FactoryBot.create(:category, name: 'Alimentação', description: 'Alimentação') }

    it 'returns all categories' do
      get '/api/v1/categories'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
          'id' => category_1.id,
          'name' => 'Limpeza',
          'description' => 'Produtos de Limpeza'
          },
          {
            'id' => category_2.id,
            'name' => 'Alimentação',
            'description' => 'Alimentação'
          }
        ]
      )
    end
  end

  describe 'DELETE /categories/:id' do
    let!(:category) { FactoryBot.create(:category, name: 'Alimentação', description: 'Alimentação') }

    it 'deletes a category' do
      expect {
        delete "/api/v1/categories/#{category.id}",
          headers: { "Authorization" => "Bearer #{jwt}" }
      }.to change { Category.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
