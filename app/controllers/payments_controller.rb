class PaymentsController < ApplicationController
  before_action :find_loan, only: [:create, :index, :show]

  def create
    pending = @loan.outstanding_balance

    if payment_params["payment_amount"] > pending
      render json: 'Your payment cannot exceed the outstanding balance of your loan', status: 422
    else
      @payment = @loan.payments.create(payment_params)
      render json: @payment
    end
  end

  def index
    render json: @loan.payments
  end

  def show
    render json: @loan.payments.find(params[:id])
  end

  private
    def payment_params
      params.require(:payment).permit(:payment_amount, :payment_date)
    end

    def find_loan
      @loan = Loan.find(params[:loan_id])
    end
end