require 'rails_helper'

RSpec.describe Services::Category::Update, type: :service do
  let!(:category) {create(:category, name: 'Lunch')}
  let(:params) {{
    name: 'Breakfast'
  }}

  subject { described_class.call(id: category.id, params: params) }

  it 'validates presence of name' do
    params[:name] = nil

    result = subject

    expect(result.failure?).to be_truthy
    expect(result.data[:error].messages).to have_key(:name)
    expect(result.data[:error].messages[:name]).to include("can't be blank")
  end

  it 'update category record' do
    result = subject

    expect(result.success?).to be_truthy
    expect(result.data).to have_key(:category)
    expect(result.data[:category].name).to eq('Breakfast')
  end
end