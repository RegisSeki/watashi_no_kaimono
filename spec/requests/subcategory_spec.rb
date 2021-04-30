require 'rails_helper'

describe 'Subcategories Api', type: :request do
  let(:user) { FactoryBot.create(:user, username: 'Yuki', email: 'yuki@cat.com', password: 'thecat', password_confirmation: 'thecat') }
  let!(:category) { FactoryBot.create(:category, name: 'Limpeza', description: 'Produtos de Limpeza') }
  let!(:jwt) { AuthenticationService.encode_token(user.id) }

  describe 'POST /subcategories' do
    it 'create a new subcategory' do
      expect {
        post '/api/v1/subcategories', params: {
          subcategory: {
            name: 'Higiene Pessoal',
            description: 'Produtos para Limpeza Pessoal',
            category_id: category.id
          }
        }, headers: { "Authorization" => "Bearer #{jwt}" }
      }.to change { Subcategory.count }.from(0).to(1)

      created_subcategory = Subcategory.last
      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          'id' => created_subcategory.id,
          'name' => 'Higiene Pessoal',
          'description' => 'Produtos para Limpeza Pessoal',
          'category' => 'Limpeza'
        }
      )
    end
  end

  describe 'UPDATE /subcategories/:id' do
    let!(:category) { FactoryBot.create(:category, name: 'Alimentação', description: 'Produtos para Alimentação') }
    let!(:subcategory) { FactoryBot.create(:subcategory, name: 'Básica', description: 'Alimentos da Cesta Básica', category_id: category.id) }

    it 'update a subcategory name' do
      put "/api/v1/subcategories/#{subcategory.id}", params: {
        subcategory: {
          name: 'Alimentos Básicos'
        }
      }, headers: { "Authorization" => "Bearer #{jwt}" }

      expect(response).to have_http_status(:ok)
      expect(response_body).to eq(
        {
          'id' => subcategory.id,
          'name' => 'Alimentos Básicos',
          'description' => 'Alimentos da Cesta Básica',
          'category' => 'Alimentação'
        }
      )
    end
  end

  describe 'GET /subcategories' do
    let!(:category) { FactoryBot.create(:category, name: 'Alimentação', description: 'Produtos para Alimentação') }
    let!(:subcategory_1) { FactoryBot.create(:subcategory, name: 'Básica', description: 'Alimentos da Cesta Básica', category_id: category.id) }
    let!(:subcategory_2) { FactoryBot.create(:subcategory, name: 'Legumes', description: 'Alimentação Complementar Saudável', category_id: category.id) }


    it 'returns all subcategories' do
      get '/api/v1/subcategories'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
          'id' => subcategory_1.id,
          'name' => 'Básica',
          'description' => 'Alimentos da Cesta Básica',
          'category' => 'Alimentação'
          },
          {
            'id' => subcategory_2.id,
            'name' => 'Legumes',
            'description' => 'Alimentação Complementar Saudável',
            'category' => 'Alimentação'
          }
        ]
      )
    end
  end

  describe 'DELETE /subcategories/:id' do
    let!(:category) { FactoryBot.create(:category, name: 'Alimentação', description: 'Alimentação') }
    let!(:subcategory) { FactoryBot.create(:subcategory, name: 'Básica', description: 'Alimentos da Cesta Básica', category_id: category.id) }
    it 'deletes a subcategory' do
      expect {
        delete "/api/v1/subcategories/#{subcategory.id}",
          headers: { "Authorization" => "Bearer #{jwt}" }
      }.to change { Subcategory.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
