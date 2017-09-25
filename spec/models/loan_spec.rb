require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to :funded_amount }
  end

  describe 'relationships' do
    it { should have_many(:payments)}
  end
end
