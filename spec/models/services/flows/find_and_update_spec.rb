require 'rails_helper'

describe Services::Flows::FindAndUpdate, type: :service do
  let!(:category) { create(:category) }
  let(:params) {{
    name: 'Lunch'
  }}
  let(:id) { category.id }

  subject { described_class.call(model: Category, id: id, params: params) }

  context 'call' do

    it { expect(subject.success?).to be_truthy }
    it { expect(subject.data).to have_key(:record) }
    it { expect(subject.data[:record]).to be_a(Category) }

    it 'returns error when not found' do
      result = described_class.call(model: Category, id: 10000, params: params)

      expect(result.failure?).to be_truthy
      expect(result.data).to eq(
        {error: "Category not found with id: 10000"}
      )
    end

    it 'returns error for invalid params' do
      params[:name] = nil

      result = subject

      expect(result.failure?).to be_truthy
      expect(result.data).to eq(
        {error: {name: ["can't be blank"]}}
      )
    end
  end
end