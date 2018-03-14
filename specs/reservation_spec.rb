require_relative 'spec_helper'

describe 'Reservation class' do

  describe 'Initializer' do
    before do
      @initial_room_number = 1
      @initial_check_in = Date.new(2018,2,3)
      @initial_check_out = Date.new(2018,2,5)
      @initial_rate = 200.0

      @reservation_info = {
        room: @initial_room_number,
        check_in: @initial_check_in,
        check_out: @initial_check_out,
        # rate: @initial_rate
      }
      @reservation = Hotel::Reservation.new(@reservation_info)
      @cost = 200.0 * 2
    end

    it 'is an instance of Reservation' do
      @reservation.must_be_instance_of Hotel::Reservation
    end

    # it 'has a reservation number' do
    #   # expected_id_num = Hotel::Reservation.get_all_reservations.size
    #   @reservation.must_respond_to :id
    #   @reservation.id.must_be_kind_of Integer
    #   @reservation.id.must_equal expected_id_num
    # end

    it 'has a room number' do
      @reservation.must_respond_to :room
      @reservation.room.must_be_kind_of Integer
      @reservation.room.must_equal @initial_room_number
    end

    it 'has a check-in date' do
      @reservation.must_respond_to :check_in
      @reservation.check_in.must_be_kind_of Date
      @reservation.check_in.must_equal @initial_check_in
    end

    it 'has a check-out date' do
      @reservation.must_respond_to :check_out
      @reservation.check_out.must_be_kind_of Date
      @reservation.check_out.must_equal @initial_check_out
    end


    it 'has a cost' do
      @reservation.must_respond_to :cost
      @reservation.cost.must_be_kind_of Float
      @reservation.cost.must_equal @cost
    end

    it 'throws an error is check-in is not a date' do
      proc {
        @reservation_info[:check_in] = 'I am not a check-in date.'
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
      proc {
        @reservation_info[:check_in] = nil
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it 'throws an error is check-out is not a date' do
      proc {
        @reservation_info[:check_out] = 'I am not a check-out date.'
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
      proc {
        @reservation_info[:check_out] = nil
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it 'throws an error if check-in is the same day as check-out' do
      proc {
        @reservation_info[:check_in] = Date.new(2018,2,5)
        @reservation_info[:check_out] = Date.new(2018,2,5)
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it 'throws an error if check-in is after check-out' do
      proc {
        @reservation_info[:check_in] = Date.new(2018,2,5)
        @reservation_info[:check_out] = Date.new(2018,2,4)
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end
  end # end of Initializer

  # describe 'Get Cost' do
  #   before do
  #     @initial_room_number = 1
  #     @initial_check_in = Date.new(2018,2,3)
  #     @initial_check_out = Date.new(2018,2,5)
  #
  #     @reservation_info = {
  #       room: @initial_room_number,
  #       check_in: @initial_check_in,
  #       check_out: @initial_check_out
  #     }
  #     @reservation = Hotel::Reservation.new(@reservation_info)
  #   end
  #
  #   it 'returns the cost' do
  #     @reservation.get_cost.must_equal 200.0 * 2
  #   end
  # end # end of 'Get Cost'


  # describe 'Conflicts With?' do
  #   before do
  #     @initial_id = 42
  #     @initial_room_number = 1
  #     @initial_check_in = Date.new(2018,2,3)
  #     @initial_check_out = Date.new(2018,2,7)
  #
  #     @reservation_info = {
  #       id: @initial_id,
  #       room_number: @initial_room_number,
  #       check_in: @initial_check_in,
  #       check_out: @initial_check_out
  #     }
  #     @reservation = Hotel::Reservation.new(@reservation_info)
  #   end
  #
  #   it 'returns \'true\' if conflicts with reservation' do
  #     start_date = Date.new(2018,2,2) # ok before but overlaps in mid
  #     end_date = Date.new(2018,2,4)
  #     @reservation.conflicts_with?(start_date, end_date).must_equal true
  #
  #     start_date_2 = Date.new(2018,2,6) # ok after but overlaps in mid
  #     end_date_2 = Date.new(2018,2,9)
  #     @reservation.conflicts_with?(start_date_2, end_date_2).must_equal true
  #
  #     start_date_3 = Date.new(2018,2,5) # fits between start and end dates
  #     end_date_3 = Date.new(2018,2,6)
  #     @reservation.conflicts_with?(start_date_3, end_date_3).must_equal true
  #
  #     start_date_3 = Date.new(2018,2,1) # completely overlaps other reservation
  #     end_date_3 = Date.new(2018,2,9)
  #     @reservation.conflicts_with?(start_date_3, end_date_3).must_equal true
  #   end
  #
  #   it 'returns \'false\' if does not conflict with reservation' do
  #     start_date = Date.new(2018,2,1)
  #     end_date = Date.new(2018,2,2) # ends day before
  #     @reservation.conflicts_with?(start_date, end_date).must_equal false
  #
  #     start_date_2 = Date.new(2018,2,8) # starts day after
  #     end_date_2 = Date.new(2018,2,9)
  #     @reservation.conflicts_with?(start_date_2, end_date_2).must_equal false
  #   end
  #
  #   it 'returns \'false\' with overlap on start and end dates' do
  #     start_date = Date.new(2018,2,1)
  #     end_date = Date.new(2018,2,3) # ends on day of check-in
  #     @reservation.conflicts_with?(start_date, end_date).must_equal false
  #
  #     start_date_2 = Date.new(2018,2,7) # starts on day of check-out
  #     end_date_2 = Date.new(2018,2,8)
  #     @reservation.conflicts_with?(start_date_2, end_date_2).must_equal false
  #   end
  #
  #   it 'throws error if invalid date value' do
  #     proc {
  #       start_date = Date.new(2018,2,1)
  #       end_date = "Look at me. I am the end date now"
  #       @reservation.conflicts_with?(start_date, end_date)
  #     }.must_raise ArgumentError
  #
  #     proc {
  #       start_date = "Look at me. I am the start date now"
  #       end_date = Date.new(2018,2,1)
  #       @reservation.conflicts_with?(start_date, end_date)
  #     }.must_raise ArgumentError
  #   end
  #
  #   it 'throws error if date range is not at least one' do
  #     proc {
  #       start_date = Date.new(2018,2,1)
  #       end_date = Date.new(2018,2,1)
  #       @reservation.conflicts_with?(start_date, end_date)
  #     }.must_raise ArgumentError
  #
  #     proc {
  #       start_date = Date.new(2018,2,5)
  #       end_date = Date.new(2018,2,4)
  #       @reservation.conflicts_with?(start_date, end_date)
  #     }.must_raise ArgumentError
  #   end
  # end # end of 'Available During Range?'




end # end of Reservation

# describe 'All Reservations' do
#   it 'can access all reservations' do
#     # Hotel::Reservation.must_respond_to :all_reservations
#     Hotel::Reservation.get_all_reservations.must_be_kind_of Array
#     # Hotel::Reservation.all_reservations.must_equal []
#     # Hotel::Reservation.all_reservations.size.must_equal 0
#   end
# end
