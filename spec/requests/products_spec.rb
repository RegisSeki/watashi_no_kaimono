require 'rails_helper'

describe 'Products Api', type: :request do
  let!(:category) { FactoryBot.create(:category, name: 'Higiene Pessoal') }
  
  describe 'POST /products' do
    it 'create a new product' do
      expect {
        post '/api/v1/products', params: { product: { name: 'Escova Dental', category_id: category.id} }
      }.to change { Product.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          'id' => 1,
          'name' => 'Escova Dental',
          'category' => 'Higiene Pessoal'
        }
      )
    end
  end

  describe 'GET /products' do
    before do
      FactoryBot.create(:product, name: 'Papel Higiênico', category_id: category.id)
      FactoryBot.create(:product, name: 'Cotonete', category_id: category.id)
    end

  	it 'returns all products' do  		
      get '/api/v1/products'

  		expect(response).to have_http_status(:success) 
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
          'id' => 2,
          'name' => 'Papel Higiênico',
          'category' => 'Higiene Pessoal'
          },
          {
            'id' => 3,
            'name' => 'Cotonete',
            'category' => 'Higiene Pessoal'
          }
        ]
      )
  	end

    it 'returns a subset of products based on limit' do
      get '/api/v1/products', params: { limit: 1 }

      expect(response).to have_http_status(:success) 
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
          'id' => 4,
          'name' => 'Papel Higiênico',
          'category' => 'Higiene Pessoal'
          }
        ]
      )
    end

    it 'returns a subset of products based on limit and offset' do
      get '/api/v1/products', params: { limit: 1, offset: 1 }

      expect(response).to have_http_status(:success) 
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
          'id' => 7,
          'name' => 'Cotonete',
          'category' => 'Higiene Pessoal'
          }
        ]
      )
    end
  end

  describe 'DELETE /products/:id' do
    let!(:product) { FactoryBot.create(:product, name: 'Escova Dental', category_id: category.id) }

    it 'deletes a product' do
      expect {
        delete "/api/v1/products/#{product.id}"
      }.to change { Product.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
