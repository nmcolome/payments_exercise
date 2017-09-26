class Loan < ActiveRecord::Base
  validates :funded_amount, presence: true

  has_many :payments

  def outstanding_balance
    self.funded_amount - self.get_total_payments
  end

  def get_total_payments
    payments = self.payments.pluck(:payment_amount).reduce(:+)
    payments == nil ? 0 : payments
  end
end
