class PaymentsController < ApplicationController
  def create
    @loan = Loan.find(params[:loan_id])
    @payment = @loan.payments.create!(payment_params)
    render json: @payment
  end

  private
    def payment_params
      params.require(:payment).permit(:payment_amount, :payment_date)
    end
end