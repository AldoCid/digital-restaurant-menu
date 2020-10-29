# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  context '.create' do
    let!(:customer_example) { create(:user) }

    it { expect(customer_example.customer?).to be_truthy }
    it {
      expect(User.create.errors.messages).to eq({
                                                  email: ["can't be blank"],
                                                  password: ["can't be blank"]
                                                })
    }

    it { expect(customer_example.products).to eq([]) }
  end
end
