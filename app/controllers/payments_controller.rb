class PaymentsController < ApplicationController
  before_action :find_loan, only: [:create, :index, :show]

  def create
    pending = @loan.outstanding_balance
    @payment = @loan.payments.new(payment_params)

    if @payment.valid? && @payment.payment_amount < pending
      @payment.save
      render json: @payment
    else
      render json: @payment.error_messages, status: 422
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