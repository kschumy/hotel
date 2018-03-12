require_relative 'spec_helper'

describe "ReservationDates" do
  include ReservationDates

  describe "has_valid_date_or_error" do
    it "returns nil if valid date" do
      has_valid_date_or_error(Date.new(2018,2,5)).must_be_nil
    end

    it "throws an error for an invalid date" do
      proc { has_valid_date_or_error("foo") }.must_raise ArgumentError
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
    # before do
    #   @initial_id = 42
    #   @initial_room_number = 1
    #   @initial_check_in = Date.new(2018,2,3)
    #   @initial_check_out = Date.new(2018,2,7)
    #
    #   @reservation_info = {
    #     id: @initial_id,
    #     room_number: @initial_room_number,
    #     check_in: @initial_check_in,
    #     check_out: @initial_check_out
    #   }
    #   @reservation = Hotel::Reservation.new(@reservation_info)
    end

    it 'returns \'true\' if conflicts with reservation' do
      start_date = Date.new(2018,2,2) # ok before but overlaps in mid
      end_date = Date.new(2018,2,4)
      conflicts_with?(start_date, end_date).must_equal true

      start_date_2 = Date.new(2018,2,6) # ok after but overlaps in mid
      end_date_2 = Date.new(2018,2,9)
      conflicts_with?(start_date_2, end_date_2).must_equal true

      start_date_3 = Date.new(2018,2,5) # fits between start and end dates
      end_date_3 = Date.new(2018,2,6)
      conflicts_with?(start_date_3, end_date_3).must_equal true

      start_date_3 = Date.new(2018,2,1) # completely overlaps other reservation
      end_date_3 = Date.new(2018,2,9)
      conflicts_with?(start_date_3, end_date_3).must_equal true
    end

    it 'returns \'false\' if does not conflict with reservation' do
      start_date = Date.new(2018,2,1)
      end_date = Date.new(2018,2,2) # ends day before
      conflicts_with?(start_date, end_date).must_equal false

      start_date_2 = Date.new(2018,2,8) # starts day after
      end_date_2 = Date.new(2018,2,9)
      conflicts_with?(start_date_2, end_date_2).must_equal false
    end

    it 'returns \'false\' with overlap on start and end dates' do
      start_date = Date.new(2018,2,1)
      end_date = Date.new(2018,2,3) # ends on day of check-in
      conflicts_with?(start_date, end_date).must_equal false

      start_date_2 = Date.new(2018,2,7) # starts on day of check-out
      end_date_2 = Date.new(2018,2,8)
      conflicts_with?(start_date_2, end_date_2).must_equal false
    end

    it 'throws error if invalid date value' do
      proc {
        start_date = Date.new(2018,2,1)
        end_date = "Look at me. I am the end date now"
        conflicts_with?(start_date, end_date)
      }.must_raise ArgumentError

      proc {
        start_date = "Look at me. I am the start date now"
        end_date = Date.new(2018,2,1)
        conflicts_with?(start_date, end_date)
      }.must_raise ArgumentError
    end

    it 'throws error if date range is not at least one' do
      proc {
        start_date = Date.new(2018,2,1)
        end_date = Date.new(2018,2,1)
        conflicts_with?(start_date, end_date)
      }.must_raise ArgumentError

      proc {
        start_date = Date.new(2018,2,5)
        end_date = Date.new(2018,2,4)
        conflicts_with?(start_date, end_date)
      }.must_raise ArgumentError
    end
  end # end of 'Available During Range?'


end
