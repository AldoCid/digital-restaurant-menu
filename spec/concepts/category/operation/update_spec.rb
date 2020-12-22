require 'rails_helper'

RSpec.describe Category::Update, type: :operation do
  let!(:category) { create(:category) }
  let(:id) { category.id }
  let(:params) {{
    name: 'Lunch1234'
  }}

  subject { described_class.(id: id, params: params) }


  it 'validates presence of id' do
    result = described_class.(id: nil, params: params)

    expect(result.success?).to be_falsey
    expect(result['option_errors']).to eq("id can't be blank")
  end

  it 'validates record existence' do
    unreached_id = 10000

    result = described_class.(id: unreached_id, params: params)

    expect(result.success?).to be_falsey
    expect(result['option_errors']).to eq("Record not found")
  end

  it 'validates presence of name' do
    params[:name] = nil

    result = subject

    expect(result.success?).to be_falsey
    expect(result[:'contract.default'].errors.messages).to have_key(:name)
    expect(result[:'contract.default'].errors.messages[:name]).to include("can't be blank")
  end

  it 'updates category record' do
    result = subject

    expect(result.success?).to be_truthy
    expect(result["model"].name).to eq('Lunch1234')
  end
end