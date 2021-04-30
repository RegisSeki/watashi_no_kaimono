require 'rails_helper'

describe 'Products Api', type: :request do
  let!(:category) { FactoryBot.create(:category, name: 'Higiene Pessoal', description: 'Limpeza do corpo') }
  let!(:subcategory) { FactoryBot.create(:subcategory, name: 'Banho', description: 'Sabonete corpo', category_id: category.id) }
  let(:user) { FactoryBot.create(:user, username: 'Yuki', email: 'yuki@cat.com', password: 'thecat', password_confirmation: 'thecat') }
  let!(:jwt) { AuthenticationService.encode_token(user.id) }

  describe 'POST /products' do
    it 'create a new product' do
      expect {
        post '/api/v1/products', params: {
          product: {
            name: 'Sabonete Dove Barra',
            subcategory_id: subcategory.id
          }
        }, headers: { "Authorization" => "Bearer #{jwt}" }
      }.to change { Product.count }.from(0).to(1)

      created_product = Product.last
      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          'id' => created_product.id,
          'name' => 'Sabonete Dove Barra',
          'category' => 'Higiene Pessoal',
          'subcategory' => 'Banho'
        }
      )
    end
  end

  describe 'UPDATE /products/:id' do
    let!(:product) { FactoryBot.create(:product, name: 'Sabonete', subcategory_id: subcategory.id) }

    it 'update a product name' do
      put "/api/v1/products/#{product.id}", params: {
        product: {
          name: 'Sabonete Protex Limpeza Profunda'
        }
      }, headers: { "Authorization" => "Bearer #{jwt}" }

      expect(response).to have_http_status(:ok)
      expect(response_body).to eq(
        {
          'id' => product.id,
          'name' => 'Sabonete Protex Limpeza Profunda',
          'category' => 'Higiene Pessoal',
          'subcategory' => 'Banho'
        }
      )
    end
  end

  describe 'GET /products' do
    let!(:product_1) { FactoryBot.create(:product, name: 'Papel Higiênico', subcategory_id: subcategory.id) }
    let!(:product_2) { FactoryBot.create(:product, name: 'Cotonete', subcategory_id: subcategory.id) }

  	it 'returns all products' do
      get '/api/v1/products'

  		expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
          'id' => product_1.id,
          'name' => 'Papel Higiênico',
          'category' => 'Higiene Pessoal',
          'subcategory' => 'Banho'
          },
          {
            'id' => product_2.id,
            'name' => 'Cotonete',
            'category' => 'Higiene Pessoal',
            'subcategory' => 'Banho'
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
          'id' => product_1.id,
          'name' => 'Papel Higiênico',
          'category' => 'Higiene Pessoal',
          'subcategory' => 'Banho'
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
          'id' => product_2.id,
          'name' => 'Cotonete',
          'category' => 'Higiene Pessoal',
          'subcategory' => 'Banho'
          }
        ]
      )
    end
  end

  describe 'DELETE /products/:id' do
    let!(:product) { FactoryBot.create(:product, name: 'Escova Dental', subcategory_id: subcategory.id) }

    it 'deletes a product' do
      expect {
        delete "/api/v1/products/#{product.id}", headers: { "Authorization" => "Bearer #{jwt}" }
      }.to change { Product.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
