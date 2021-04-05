require 'rails_helper'

describe 'Categories Api', type: :request do
  describe 'GET /categories' do
    before do
      FactoryBot.create(:category, name: 'Higiene Pessoal')
      FactoryBot.create(:category, name: 'Alimentação')
    end

    it 'returns all categories' do
      get '/api/v1/categories'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /categories' do
    it 'create a new category' do
      expect {
        post '/api/v1/categories', params: { category: { name: 'Higiene Pessoal' }}
      }.to change { Category.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /categories/:id' do
    let!(:category) { FactoryBot.create(:category, name: 'Alimentação') }

    it 'deletes a category' do
      expect {
        delete "/api/v1/categories/#{category.id}"
      }.to change { Category.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end 
end
