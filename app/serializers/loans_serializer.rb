class LoansSerializer < ActiveModel::Serializer
  attributes :id, :funded_amount, :outstanding_balance, :created_at, :updated_at

  def outstanding_balance
    object.outstanding_balance
  end
end