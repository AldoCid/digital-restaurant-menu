require 'rails_helper'

describe Api::ApiController, type: :controller do
  let!(:user) { create(:user) }

  controller do
    def index
      render json: 'controller test', status: :ok
    end
  end

  it 'validates if user is logged' do
    get :index

    expect(response.status).to eq(401)
    expect(JSON.parse(response.body)).to eq({"error" => 'authentication error'})
  end

  it 'run route logic if user is logged' do
    sign_in user

    get :index

    expect(response.status).to eq(200)
    expect(response.body).to eq('controller test')
  end
end