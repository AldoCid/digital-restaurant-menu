require 'rails_helper'

RSpec.describe Category, type: :model do
  context '.create' do
    let!(:user) { create(:user, id: 1) }
    let(:data) do
      {
        name: 'dessert',
        user: user
      }
    end

    subject { described_class.create(data) }

    it 'creates a new category record' do
      expect { Category.create(data) }.to change { Category.count }.by(1)
      expect(Category.last.attributes.except('id', 'created_at', 'updated_at')).to eq({
        'name' => 'dessert',
        'active' => true,
        'user_id' => 1
      })
    end

    it 'raises error when user is empty' do
      data[:user] = nil

      expect(subject.errors.messages).to eq(user: ['must exist'])
    end

  end

  context '.update' do
    context 'when update active column' do
      let!(:category) { create(:category)}
      let!(:products) { create_list(:product, 5, category: category, user: category.user)}
      let!(:service) { Services::Category::Products::FlipActivation }

      it 'calls Services::Category::Products::FlipActivation service' do
        expect(service).to receive(:call)

        category.update(active: false)
      end
    end
  end
end
