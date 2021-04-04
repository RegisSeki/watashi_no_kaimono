require 'rails_helper'

describe 'Products Api', type: :request do
  describe 'GET /products' do
    before do
      FactoryBot.create(:product, name: 'Papel Higiênico', category: 'Higiene Pessoal')
      FactoryBot.create(:product, name: 'Cotonete', category: 'Higiene Pessoal')
    end
  	it 'returns all products' do  		
      get '/api/v1/products'

  		expect(response).to have_http_status(:success) 
      expect(JSON.parse(response.body).size).to eq(2)
  	end
  end

  describe 'POST /products' do
    it 'create a new product' do
      expect {
        post '/api/v1/products', params: { product: { name: 'Escova Dental', category: 'Higiene Pessoal'} }
      }.to change { Product.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) { FactoryBot.create(:product, name: 'Escova Dental', category: 'Higiene Pessoal') }

    it 'deletes a product' do
      expect {
        delete "/api/v1/products/#{book.id}"
      }.to change { Product.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
