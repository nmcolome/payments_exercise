require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:valid_params) { { payment_amount: 20.0, payment_date: Date.today } }

    context 'payment_amount < outstanding_balance' do
      it 'responds with a 200' do
        post :create, { loan_id: loan.id, payment: valid_params, format: :json }
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new payment' do
        expect {
          post :create, { loan_id: loan.id, payment: valid_params, format: :json }
        }.to change(Payment, :count).by(1)
      end
    end
  end
end
