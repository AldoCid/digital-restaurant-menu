require 'rails_helper'

describe Services::Create, type: :service do
  let!(:user) { create(:user) }
  let(:category_params) {{
    name: 'Breakfast',
    user_id: user.id
  }}

  subject { described_class.call(model: Category, params: category_params) }

  context 'call' do

    it { expect(subject.success?).to be_truthy }
    it { expect(subject.data).to have_key(:record) }
    it { expect(subject.data[:record].persisted?).to be_truthy }
    it { expect(subject.data[:record]).to be_a(Category) }

    it 'returns error for unsupported param' do
      category_params[:unsupported_param] = '123'

      result = described_class.call(model: Category, params: category_params)

      expect(result.failure?).to be_truthy
      expect(result.data).to have_key(:error)
    end

    it 'returns error for invalid param' do
      category_params[:user_id] = nil

      result = described_class.call(model: Category, params: category_params)

      expect(result.failure?).to be_truthy
      expect(result.data).to have_key(:error)
    end
  end

end