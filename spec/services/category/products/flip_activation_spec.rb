require 'rails_helper'

RSpec.describe Services::Category::Products::FlipActivation, type: :service do
  let!(:category) {create(:category, active: false)}
  let!(:products) {
    create_list(:product, 5, category: category, user: category.user)
  }

  subject {described_class.call(category: category)}

  it 'returns error for 0 related products' do
    category.products.destroy_all
    category.reload

    result = subject

    expect(result.success?).to be_falsey
    expect(result.data).to have_key(:error)
    expect(result.data[:error]).to eq('Category without products!')
  end

  context 'for inactive category' do
    it 'inactive related products' do
      result = subject
      expect(result.success?).to be_truthy
      expect(category.products.pluck(:active)).to eq([false, false, false, false, false])
    end
  end

  context 'for active category' do
    it 'active related products' do
      category.update(active: true)

      result = subject
      expect(result.success?).to be_truthy
      expect(category.products.pluck(:active)).to eq([true, true, true, true, true])
    end
  end
end