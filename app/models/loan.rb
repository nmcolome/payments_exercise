class Loan < ActiveRecord::Base
  has_many :payments

  def outstanding_balance_calc
    payments = self.payments.pluck(:payment_amount).reduce(:+)
    total_payments = payments == nil ? 0 : payments
    self.funded_amount - total_payments
  end
end
