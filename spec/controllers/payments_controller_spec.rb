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

    context 'payment_amount > outstanding_balance' do
      let(:invalid_params) { { payment_amount: 500.0, payment_date: Date.today } }

      it 'responds with a 422' do
        post :create, { loan_id: loan.id, payment: invalid_params, format: :json }
        expect(response).to have_http_status(422)
        expect(response.body).to eq("Your payment cannot exceed the outstanding balance of your loan")
      end
    end
  end

  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 150.0) }
    let(:valid_params) { { payment_amount: 50.0, payment_date: Date.today } }
    let(:valid_params) { { payment_amount: 80.0, payment_date: Date.today } }

    it 'responds with a 200' do
      get :index, { loan_id: loan.id, format: :json }
      expect(response).to have_http_status(:ok)
    end
  end
end
