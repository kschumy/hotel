require_relative 'spec_helper'

describe "ReservationDates" do

  include ReservationDates

  describe "has_date_or_error" do
    it "returns nil if valid date" do
      has_date_or_error(Date.new(2018,2,5)).must_be_nil
    end

    it "throws an error for an invalid date" do
      proc { has_date_or_error("foo") }.must_raise ArgumentError
    end
  end

  describe "check_if_valid_dates" do
    it 'returns nil if valid dates' do
      start_date = Date.new(2018,2,1)
      end_date = Date.new(2018,2,2)
      check_if_valid_dates(start_date, end_date).must_be_nil
    end

    it 'throws error if invalid date value' do
      proc {
        start_date = Date.new(2018,2,1)
        end_date = "Look at me. I am the end date now"
        check_if_valid_dates(start_date, end_date)
      }.must_raise ArgumentError

      proc {
        start_date = "Look at me. I am the start date now"
        end_date = Date.new(2018,2,1)
        check_if_valid_dates(start_date, end_date)
      }.must_raise ArgumentError
    end

    it 'throws error if date range is not at least one' do
      proc {
        start_date = Date.new(2018,2,1)
        end_date = Date.new(2018,2,1)
        check_if_valid_dates(start_date, end_date)
      }.must_raise ArgumentError
    end

    it 'throws error if start date after end date' do
      proc {
        start_date = Date.new(2018,2,5)
        end_date = Date.new(2018,2,4)
        check_if_valid_dates(start_date, end_date)
      }.must_raise ArgumentError
    end
  end

  describe 'Conflicts With?' do

    DateRange = Struct.new(:check_in, :check_out)

    before do
      @default_dates = DateRange.new(Date.new(2018,2,3), Date.new(2018,2,7))
    end

    it 'returns \'true\' if conflicts with reservation' do
      # ok before but overlaps in mid
      test_dates_1 = DateRange.new(Date.new(2018,2,2), Date.new(2018,2,4))
      conflicts_with_dates?(test_dates_1, @default_dates).must_equal true
      conflicts_with_dates?(@default_dates, test_dates_1).must_equal true

      # ok after but overlaps in mid
      test_dates_2 = DateRange.new(Date.new(2018,2,6), Date.new(2018,2,9))
      conflicts_with_dates?(test_dates_2, @default_dates).must_equal true
      conflicts_with_dates?(@default_dates, test_dates_2).must_equal true

      # fits between start and end dates
      test_dates_3 = DateRange.new(Date.new(2018,2,5), Date.new(2018,2,6))
      conflicts_with_dates?(test_dates_3, @default_dates).must_equal true
      conflicts_with_dates?(@default_dates, test_dates_3,).must_equal true

      # completely overlaps other reservation
      test_dates_4 = DateRange.new(Date.new(2018,2,1), Date.new(2018,2,9))
      conflicts_with_dates?(test_dates_4, @default_dates).must_equal true
      conflicts_with_dates?( @default_dates, test_dates_4).must_equal true
    end

    it 'returns \'false\' if does not conflict with reservation' do
      # ends day before
      test_dates_1 = DateRange.new(Date.new(2018,2,1), Date.new(2018,2,2))
      conflicts_with_dates?(test_dates_1, @default_dates).must_equal false
      conflicts_with_dates?(@default_dates, test_dates_1).must_equal false

      # starts day after
      test_dates_2 = DateRange.new(Date.new(2018,2,8), Date.new(2018,2,9))
      conflicts_with_dates?(test_dates_2, @default_dates).must_equal false
      conflicts_with_dates?(@default_dates, test_dates_2).must_equal false
    end

    it 'returns \'false\' with overlap on start and end dates' do
      # ends on day of check-in
      test_dates_1 = DateRange.new(Date.new(2018,2,1), Date.new(2018,2,3))
      conflicts_with_dates?(test_dates_1, @default_dates).must_equal false
      conflicts_with_dates?(@default_dates, test_dates_1).must_equal false

      # starts on day of check-out
      test_dates_2 = DateRange.new(Date.new(2018,2,7), Date.new(2018,2,8))
      conflicts_with_dates?(test_dates_2, @default_dates).must_equal false
      conflicts_with_dates?(test_dates_2, @default_dates).must_equal false
    end

    it 'throws error if invalid date value' do
      proc {
        end_date = "Look at me. I am the end date now"
        bad_test_dates_1 = DateRange.new(Date.new(2018,2,1), end_date)
        conflicts_with_dates?(bad_test_dates_1, @default_dates)
      }.must_raise ArgumentError

      proc {
        end_date = "Look at me. I am the end date now"
        bad_test_dates_1 = DateRange.new(Date.new(2018,2,1), end_date)
        conflicts_with_dates?(@default_dates, bad_test_dates_1)
      }.must_raise ArgumentError

      proc {
        start_date = "Look at me. I am the start date now"
        bad_test_dates_2 = DateRange.new(start_date, Date.new(2018,2,1))
        conflicts_with_dates?(bad_test_dates_2, @default_dates)
      }.must_raise ArgumentError

      proc {
        start_date = "Look at me. I am the start date now"
        bad_test_dates_2 = DateRange.new(start_date, Date.new(2018,2,1))
        conflicts_with_dates?(@default_dates, bad_test_dates_2)
      }.must_raise ArgumentError

    end

    it 'throws error if date range is not at least one' do
      proc {
        bad_test_dates_1 = DateRange.new(Date.new(2018,2,1), Date.new(2018,2,1))
        conflicts_with_dates?(bad_test_dates_1, @default_dates)
      }.must_raise ArgumentError

      proc {
        bad_test_dates_1 = DateRange.new(Date.new(2018,2,1), Date.new(2018,2,1))
        conflicts_with_dates?(@default_dates, bad_test_dates_1)
      }.must_raise ArgumentError

      proc {
        bad_test_dates_2 = DateRange.new(Date.new(2018,2,5), Date.new(2018,2,4))
        conflicts_with_dates?(bad_test_dates_2, @default_dates)
      }.must_raise ArgumentError

      proc {
        bad_test_dates_2 = DateRange.new(Date.new(2018,2,5), Date.new(2018,2,4))
        conflicts_with_dates?(@default_dates, bad_test_dates_2)
      }.must_raise ArgumentError
    end
  end # end of 'Available During Range?'


end
