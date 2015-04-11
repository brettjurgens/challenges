# transaction.rb
class Transaction
  attr_reader :day, :amount

  def initialize(amount, day)
    @amount = amount
    @day = day
  end
end
