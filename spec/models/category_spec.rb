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
      expect(Category.last.name).to eq('dessert')
    end

    it 'raises error when user is empty' do
      data[:user] = nil

      expect(subject.errors.messages).to eq(user: ['must exist'])
    end
  end
end
