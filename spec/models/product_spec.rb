require 'rails_helper'

RSpec.describe Product, type: :model do
  context '.create' do
    let!(:user) { create(:user, id: 1) }
    let!(:category) { create(:category, id: 1) }
    let(:data) do
      {
        title: 'Brigadeiro',
        description: 'Delicious Brazillian dessert',
        price: 1.0,
        user: user,
        category: category
      }
    end

    subject { Product.create(data) }

    it 'creates a new product record' do
      expect { subject }.to change { Product.count }.by(1)
      expect(Product.last.attributes.except('id', 'created_at', 'updated_at')).to eq({
                                                                                       'title' => 'Brigadeiro',
                                                                                       'description' => 'Delicious Brazillian dessert',
                                                                                       'price' => 1.0,
                                                                                       'user_id' => 1,
                                                                                       'category_id' => 1
                                                                                     })
    end

    it 'return error for required fields' do
      data[:user], data[:category] = nil

      expect(subject.errors.messages).to eq(user: ['must exist'], category: ['must exist'])
    end
  end
end
