class LoansController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.all, each_serializer: LoansSerializer
  end

  def show
    render json: Loan.find(params[:id]), serializer: LoansSerializer
  end
end
