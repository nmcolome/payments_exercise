class Payment < ActiveRecord::Base
  validates :payment_amount, presence: true
  validates :payment_date, presence: true

  belongs_to :loan
end
