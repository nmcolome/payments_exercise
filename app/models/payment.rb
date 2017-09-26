class Payment < ActiveRecord::Base
  validates :payment_amount, presence: true
  validates :payment_date, presence: true

  belongs_to :loan

  def error_messages
    if self.valid?
      'Your payment cannot exceed the outstanding balance of your loan'
    else
      self.errors.full_messages
    end
  end
end
