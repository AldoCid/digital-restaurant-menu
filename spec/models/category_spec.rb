require 'rails_helper'

RSpec.describe Category, type: :model do
  context '.create' do
    let(:data) {{ name: 'dessert' }}

    it 'creates a new category record' do
      expect { Category.create(data) }.to change { Category.count }.by(1)
      expect(Category.last.name).to eq('dessert')
    end
  end
end
