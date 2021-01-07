require 'rails_helper'

describe Services::Find, type: :service do
  let!(:product) { create(:product) }

  subject { described_class.call(model: Product, id: product.id) }

  context 'call' do
    it { expect(subject.data).to have_key(:record) }

    it 'returns record of giving model type' do
      product_result = subject
      category_result = described_class.call(model: Category, id: product.category.id)

      expect(product_result.data[:record]).to be_a(Product)
      expect(category_result.data[:record]).to be_a(Category)
    end

    it 'returns error when not found' do
      result = described_class.call(model: Category, id: 10000)

      expect(result.failure?).to be_truthy
      expect(result.data).to eq(
        {error: "Category not found with id: 10000"}
      )
    end
  end

end