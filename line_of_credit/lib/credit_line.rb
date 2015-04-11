require_relative './ledger_entry'

# CreditLine Class
# Represents a single CreditLine
class CreditLine
  attr_reader :apr, :limit

  def initialize(apr, limit)
    @apr = apr
    @limit = limit
    @cycle = 30
    @ledger = {}
  end

  def borrow(amount, day)
    add_transaction amount, day, 1
  end

  def pay(amount, day)
    add_transaction amount, day, -1
  end

  def compute_interest(day)
    month = get_month day - 1
    if month < 0 || !@ledger.key?(month)
      0
    else
      @ledger[month].interest
    end
  end

  def transactions(month)
    @ledger[month].sorted_transactions
  end

  private

  def get_month(day)
    # this *should* automatically floor, unless a float is given for day.
    # let's just make sure though.
    (day / @cycle).floor
  end

  # Adds a transaction to the ledger, updates borrowed sum
  # and calculates an interest delta (i.e. change in interest)
  def add_transaction(amount, day, multiplier)
    month = get_month day

    amount *= multiplier

    if can_borrow month, amount
      @ledger[month] = LedgerEntry.new unless @ledger.key?(month)
      interest_delta = amount * @apr * (@cycle - day + 1) / 365
      @ledger[month].update amount, day, interest_delta
    else
      fail ArgumentError, 'Over credit limit'
    end
  end

  # Checks if a user can actually borrow the money they're asking for
  def can_borrow(month, amount)
    amount <= @limit ||
      (@ledger.key?(month) && @ledger[month].borrowed + amount <= @limit)
  end
end
