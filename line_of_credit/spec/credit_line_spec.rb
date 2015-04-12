require 'minitest/autorun'
require 'minitest/spec'
require_relative '../lib/credit_line'

describe CreditLine do
  before do
    @creditline = CreditLine.new 0.35, 1000
  end

  describe 'when initializing a credit line' do
    it 'must initialize all information' do
      @creditline.apr.must_equal 0.35
      @creditline.limit.must_equal 1000
    end
  end

  describe 'when borrowing/paying' do
    it 'should update interest' do
      @creditline.borrow 500, 1
      @creditline.compute_interest(30).round(2).must_equal 14.38
    end

    it 'should not let you overborrow' do
      begin
        @creditline.borrow 10_000, 1
        flunk
      rescue ArgumentError
        pass
      end
    end

    it 'should let you borrow and pay' do
      @creditline.borrow 500, 1
      @creditline.pay 200, 15
      @creditline.borrow 100, 25

      @creditline.compute_interest(30).round(2).must_equal 11.89
    end

    it 'should return sorted transactions' do
      @creditline.borrow 500, 1
      @creditline.pay 200, 15

      transactions = @creditline.transactions 0

      transactions.first.amount.must_equal 500
      transactions.first.day.must_equal 1
      transactions.last.amount.must_equal(-200)
      transactions.last.day.must_equal 15
    end

    it 'should work when transactions are only in a later month' do
      @creditline.borrow 500, 31
      @creditline.pay 200, 45
      @creditline.borrow 100, 55

      @creditline.compute_interest(60).round(2).must_equal 11.89
    end

    it 'should keep track of multiple months of interest' do
      @creditline.borrow 500, 1
      @creditline.pay 200, 15
      @creditline.borrow 100, 25

      @creditline.borrow 500, 31
      @creditline.pay 200, 45
      @creditline.borrow 100, 55

      @creditline.compute_interest(60).round(2).must_equal 23.78
    end
  end
end
