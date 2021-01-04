require 'rails_helper'
require 'json'

describe Api::V1::CategoriesController, type: :controller do
  let(:category) { create(:category) }
  let(:user) { category.user }

  before(:each) do
    sign_in user
  end

  context 'GET index' do
    subject { get :index }

    it { expect(subject).to have_http_status(200) }
    it { expect(subject.body).to eq(user.categories.to_json) }
  end

  context 'GET show' do
    subject { get :show, params: { id: category.id } }
    it { expect(subject).to have_http_status(200) }
    it { expect(subject.body).to eq(category.attributes.to_json) }
  end

  context 'POST create' do
    let(:params) {{ name: 'dessert'}}

    subject { post :create, params: params }

    it { expect(subject).to have_http_status(200) }
    it { expect(JSON.parse(subject.body).except('created_at', 'updated_at', 'id')).to eq({
      'name' => 'dessert',
      'user_id'=> user.id,
      'active' => true
      })}

    it 'render error for empty name' do
      params[:name] = nil

      response = subject

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)).to eq({"name"=>["can't be blank"]})
    end
  end

  context 'PUT update' do
    let(:category) { create(:category) }
    let(:params) {{
      id: category.id,
      name: 'Dinner'
    }}

    subject { put :update, params: params }

    it { expect(subject).to have_http_status(200) }
    it { expect(JSON.parse(subject.body).except('created_at', 'updated_at', 'id')).to eq({
      'name' => 'Dinner',
      'user_id'=> user.id,
      'active' => true
      })}

    it 'return error if category is not found' do
      params[:id] = 10000

      expect(subject).to have_http_status(422)
    end
  end
end