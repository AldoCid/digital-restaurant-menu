require 'rails_helper'

RSpec.describe Services::Category::Create, type: :service do
  let(:user) { create(:user) }
  let(:params) {{
    name: 'Breakfast'
  }}

  subject { described_class.call(params: params, user: user) }

  it 'validates presence of user' do
    result = described_class.call(params: params, user: nil)

    expect(result.failure?).to be_truthy
    expect(result.data[:error].messages).to have_key(:user)
    expect(result.data[:error].messages[:user]).to include('must exist')
  end

  it 'validates presence of name' do
    params[:name] = nil

    result = subject

    expect(result.failure?).to be_truthy
    expect(result.data[:error].messages).to have_key(:name)
    expect(result.data[:error].messages[:name]).to include("can't be blank")
  end

  it 'creates new category record' do
    result = subject

    expect(result.success?).to be_truthy
    expect(result.data).to have_key(:category)
    expect(result.data[:category].persisted?).to be_truthy
    expect(result.data[:category].name).to eq('Breakfast')
    expect(result.data[:category].user_id).to eq(user.id)
  end
end