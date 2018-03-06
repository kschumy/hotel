require_relative 'spec_helper'

describe "Hotel Module" do

  describe "has_valid_date_or_error" do
    it "does not throw an error for a valid date" do
      Hotel.has_valid_date_or_error(Date.new(2018,2,5)).must_be_nil
    end

    it "throws an error for an invalid date" do
      proc { Hotel.has_valid_date_or_error("foo") }.must_raise ArgumentError
    end
  end

  describe "check_if_valid_dates" do
    it 'returns nil if valid dates' do
        start_date = Date.new(2018,2,1)
        end_date = Date.new(2018,2,5)
        Hotel.check_if_valid_dates(start_date, end_date)
    end

    it 'throws error if invalid date value' do
      proc {
        start_date = Date.new(2018,2,1)
        end_date = "Look at me. I am the end date now"
        Hotel.check_if_valid_dates(start_date, end_date)
      }.must_raise ArgumentError

      proc {
        start_date = "Look at me. I am the start date now"
        end_date = Date.new(2018,2,1)
        Hotel.check_if_valid_dates(start_date, end_date)
      }.must_raise ArgumentError
    end

    it 'throws error if date range is not at least one' do
      proc {
        start_date = Date.new(2018,2,1)
        end_date = Date.new(2018,2,1)
        Hotel.check_if_valid_dates(start_date, end_date)
      }.must_raise ArgumentError

      proc {
        start_date = Date.new(2018,2,5)
        end_date = Date.new(2018,2,4)
        Hotel.check_if_valid_dates(start_date, end_date)
      }.must_raise ArgumentError
    end
  end

end
