require_relative './transaction'
# ledger_entry.rb
class LedgerEntry
  attr_reader :interest, :borrowed, :transactions

  def initialize
    # Running Interest Total, Total Borrowed, List of Transaction(day, amount)
    @interest = 0
    @borrowed = 0
    @transactions = []
  end

  def update(amount, day, delta)
    add_transaction amount, day
    update_interest delta
    update_borrowed amount
  end

  def sorted_transactions
    transactions.sort { |a, b| a.day <=> b.day }
  end

  private

  def add_transaction(amount, day)
    @transactions << Transaction.new(amount, day)
  end

  def update_interest(delta)
    @interest += delta
  end

  def update_borrowed(amount)
    @borrowed += amount
  end
end
