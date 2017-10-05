class PaymentsController < ApplicationController
  def index
    render json: Payment.all
  end
end