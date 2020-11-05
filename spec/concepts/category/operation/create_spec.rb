require 'rails_helper'

RSpec.describe Category::Create, type: :operation do
  let!(:user) { create(:user) }
  let(:params) {{
    name: 'Breakfast'
  }}

  subject { described_class.(params: params, user: user) }

  it 'validates presence of user' do
    result = described_class.(params: params, user: nil)

    expect(result.success?).to be_falsey
    expect(result['model'].persisted?).to be_falsey
    expect(result['option_errors']).to include("user can't be blank")
  end

  it 'validates presence of name' do
    params[:name] = nil

    result = subject

    expect(result.success?).to be_falsey
    expect(result[:'contract.default'].errors.messages).to have_key(:name)
    expect(result[:'contract.default'].errors.messages[:name]).to include("can't be blank")
  end

  it 'creates new category record' do
    result = subject

    expect(result.success?).to be_truthy
    expect(result["model"].persisted?).to be_truthy
    expect(result["model"].name).to eq('Breakfast')
    expect(result["model"].user_id).to eq(user.id)
  end
end