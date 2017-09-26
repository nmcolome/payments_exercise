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

    context 'absence of amount' do
      let(:no_amount) { { payment_date: Date.today } }

      it 'responds with a 422' do
        post :create, { loan_id: loan.id, payment: no_amount, format: :json }
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)[0]).to eq("Payment amount can't be blank")
      end
    end

    context 'absence of date' do
      let(:no_date) { { payment_amount: 500.0 } }

      it 'responds with a 422' do
        post :create, { loan_id: loan.id, payment: no_date, format: :json }
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)[0]).to eq("Payment date can't be blank")
      end
    end
  end

  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 150.0) }

    it 'is successful' do
      get :index, { loan_id: loan.id, format: :json }
      expect(response).to have_http_status(:ok)
    end

    it 'returns attributes' do
      loan.payments.create!(payment_amount: 50.0, payment_date: Date.today)
      loan.payments.create!(payment_amount: 80.0, payment_date: Date.today)

      get :index, { loan_id: loan.id, format: :json }
      payments = JSON.parse(response.body)
      first_pay = payments[0]

      expect(payments.count).to eq(2)
      expect(first_pay).to have_key("id")
      expect(first_pay).to have_key("loan_id")
      expect(first_pay).to have_key("payment_amount")
      expect(first_pay).to have_key("payment_date")
      expect(first_pay["loan_id"]).to eq(loan.id)
      expect(first_pay["payment_amount"].to_f).to eq(50.0)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 150.0) }
    let(:payment) { loan.payments.create!(payment_amount: 80.0, payment_date: Date.today) }

    it 'responds with a 200' do
      get :show, id: payment.id, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end

    it 'returns attributes' do
      get :show, id: payment.id, loan_id: loan.id
      pay = JSON.parse(response.body)

      expect(pay).to have_key("id")
      expect(pay).to have_key("loan_id")
      expect(pay).to have_key("payment_amount")
      expect(pay).to have_key("payment_date")
      expect(pay["loan_id"]).to eq(loan.id)
      expect(pay["payment_amount"].to_f).to eq(payment.payment_amount)
    end
  end
end
