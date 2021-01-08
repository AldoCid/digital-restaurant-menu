require 'rails_helper'

RSpec.describe Services::Update, type: :service do
  let!(:category) {create(:category, name: 'Lunch')}
  let(:params) {{
    name: 'Breakfast'
  }}

  subject {
    described_class.call(
      record: category,
      params: params
    )
  }

  it { expect(subject.data).to have_key(:record) }
  it { expect(subject.data[:record]).to be_a(ApplicationRecord) }

  it 'returns error for unsupported param' do
    params[:unsupported_param] = '123'

    result = described_class.call(record: category, params: params)

    expect(result.failure?).to be_truthy
    expect(result.data).to have_key(:error)
    expect(result.data[:error]).to be_a(String)
  end

  it 'returns error for invalid param' do
    params[:name] = nil

    result = described_class.call(record: category, params: params)

    expect(result.failure?).to be_truthy
    expect(result.data).to have_key(:error)
  end
end