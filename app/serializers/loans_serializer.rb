class LoansSerializer < ActiveModel::Serializer
  attributes :id, :funded_amount, :outstanding_balance, :created_at, :updated_at

  def outstanding_balance
    payments = object.payments.pluck(:payment_amount).reduce(:+)
    total_payments = payments == nil ? 0 : payments
    object.funded_amount - total_payments
  end
end