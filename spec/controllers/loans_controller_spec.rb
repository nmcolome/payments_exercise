require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    let!(:loan) { Loan.create!(funded_amount: 150.0) }

    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'attributes' do
      loan.payments.create!(payment_amount: 50.0, payment_date: Date.today)

      get :index
      first_loan = JSON.parse(response.body).first

      expect(first_loan["id"]).to eq(loan.id)
      expect(first_loan["funded_amount"].to_f).to eq(loan.funded_amount)
      expect(first_loan["outstanding_balance"].to_f).to eq(100.0)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, id: loan.id
      expect(response).to have_http_status(:ok)
    end
    
    it 'attributes' do
      loan.payments.create!(payment_amount: 85.0, payment_date: Date.today)

      get :show, id: loan.id
      show_loan = JSON.parse(response.body)

      expect(show_loan["id"]).to eq(loan.id)
      expect(show_loan["funded_amount"].to_f).to eq(loan.funded_amount)
      expect(show_loan["outstanding_balance"].to_f).to eq(15.0)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
