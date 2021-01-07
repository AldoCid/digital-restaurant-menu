require 'rails_helper'

describe Services::Product::Create, type: :service do
  let(:category) { create(:category) }
  let(:user) { create(:user) }
  let(:params) do
    {
      'title' => 'Cheeseburger',
      'description' => 'Delicious burger with cheese and bread',
      'price' => 5.0,
      'active' => true,
      'category_id' => category.id
    }
  end

  subject { described_class.call(params: params, user_id: user.id) }

  describe '.call' do
    context 'happy path' do
      it 'creates product succefully' do
        result = subject

        expect(result.success?).to be_truthy
        expect(result.data).to have_key(:product)
        expect(result.data[:product]).to be_a(Product)
        expect(result.data[:product].persisted?).to be_truthy
        expect(result.data[:product].attributes.except('id',  'created_at', 'updated_at')).to eq({
                                                                                        'title' => 'Cheeseburger',
                                                                                        'description' => 'Delicious burger with cheese and bread',
                                                                                        'price' => 5.0,
                                                                                        'active' => true,
                                                                                        'category_id' => category.id,
                                                                                        'user_id' => user.id
                                                                                      })
      end
    end

    context 'validations' do
      it 'return errors for each required field' do
        params[:title],
        params[:price],
        params[:category_id] = nil

        result = described_class.call(params: params, user: nil)

        expect(result.failure?).to be_truthy
        expect(result[:error]).to include(:title, :price, :category, :user)
        expect(result[:error].messages).to eq({
                                                 title: ["can't be blank"],
                                                 price: ["can't be blank"],
                                                 category: ['must exist'],
                                                 user: ['must exist']
                                               })
      end
    end
  end
end
