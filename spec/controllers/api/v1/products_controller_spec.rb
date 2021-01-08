require 'rails_helper'

describe Api::V1::ProductsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let(:product) { create(:product, user: user, category: category) }

  before { sign_in user }

  context 'GET index' do
    let!(:products) { create_list(:product, 5, user: user, category: category) }

    subject { get :index }

    it { expect(subject).to have_http_status(200) }
    it { expect(subject.body).to eq(user.products.to_json) }
  end

  context 'GET show' do
    subject { get :show, params: { id: product.id } }

    it { expect(subject).to have_http_status(200)}
    it { expect(subject.body).to eq(product.attributes.to_json) }
  end

  context 'POST create' do
    let(:category) {create(:category)}
    let(:params) {{
      title: 'Cheeseburger',
      description: 'Delicious burger with cheese and bread',
      price: 5,
      category_id: category.id,
    }}

    subject { post :create, params: params }

    it 'returns persisted object' do
      expect(JSON.parse(subject.body).except('id', 'created_at', 'updated_at')).to eq({
        "title"=>'Cheeseburger',
        "description"=>'Delicious burger with cheese and bread',
        "price"=> 5.0,
        "active"=>true,
        "category_id"=> category.id,
        "user_id"=> user.id
      })
    end

    it 'validates title and category presence' do
      params[:title], params[:price], params[:category_id] = nil

      expect(subject).to have_http_status(422)
      expect(JSON.parse(subject.body)).to eq({
        "price" => ["can't be blank"],
        "title"=>["can't be blank"],
        "category"=>["must exist"]
      })
    end

    it 'ignores unsupported params' do
      params[:unsupported_param] = '123'

      expect(subject).to have_http_status(200)
    end
  end

  context 'PUT update' do
    let(:params) {{
      id: product.id,
      title: 'Donut',
      price: 10.0,
      description: 'Delicious donut',
      active: false,
    }}

    subject { put :update, params: params}

    it {expect(subject).to have_http_status(200)}
    it {expect(JSON.parse(subject.body).except('id', 'created_at', 'updated_at')).to eq({
      "title"=>'Donut',
      "description"=>'Delicious donut',
      "category_id"=>category.id,
      "active"=>false,
      "price" => 10.0,
      "user_id"=>user.id
    })}

    it 'render errors for required fields' do
      params[:title], params[:price], params[:category_id] = nil

      expect(subject).to have_http_status(422)
      expect(JSON.parse(subject.body)).to eq({
        "price" => ["can't be blank"],
        "title"=>["can't be blank"],
        "category"=>["must exist"]
      })
    end

    it 'return error if product is not found' do
      params[:id] = 10000

      expect(subject).to have_http_status(422)
      expect(JSON.parse(subject.body)).to eq({"error"=> "Couldn't find Product with 'id'=10000"})
    end
  end
end
