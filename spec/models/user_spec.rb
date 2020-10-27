# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  context '.create' do
    let(:customer_example) do
      {
        name: 'Mac Demarco',
        email: 'mac@indie.com',
        phone: '8566669999',
        address: 'Rua dos Pinheiros'
      }
    end

    it 'creates customer user by default' do
      new_user = User.create(customer_example)
      expect(new_user.customer?).to be_truthy
    end

    it {
      expect(User.create.errors.messages).to eq({
                                                  email: ["can't be blank"],
                                                  password: ["can't be blank"]
                                                })
    }
  end
end
