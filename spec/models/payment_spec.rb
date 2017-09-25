require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to :loan_id }
    it { is_expected.to respond_to :payment_amount }
    it { is_expected.to respond_to :payment_date }
  end

  describe 'relationships' do
    it { should belong_to(:loan)}
  end
end
