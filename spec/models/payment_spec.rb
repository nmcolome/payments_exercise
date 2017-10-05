require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "attributes" do
    it { is_expected.to respond_to(:date)}
    it { is_expected.to respond_to(:amount)}
  end
end
