class PaymentsController < ApplicationController
  def create
    @loan = Loan.find(params[:loan_id])
    pending = @loan.outstanding_balance_calc

    if payment_params["payment_amount"] > pending
      render json: 'Your payment cannot exceed the outstanding balance of your loan', status: 422
    else
      @payment = @loan.payments.create!(payment_params)
      render json: @payment
    end

    def index
      @loan = Loan.find(params[:loan_id])
      render json: @loan.payments
    end

    def show
      @loan = Loan.find(params[:loan_id])
      render json: @loan.payments.find(params[:id])
    end
  end

  private
    def payment_params
      params.require(:payment).permit(:payment_amount, :payment_date)
    end
end