require_relative 'spec_helper'

describe 'Block class' do

  TestDates = Struct.new(:check_in, :check_out)

  describe 'Initializer' do
    before do

      # @manager = Hotel::Block.new(@test_info)
    end

    it 'is an instance of HotelManager' do
      test_info = {rooms: Set[1, 2], check_in: Date.new(2018,2,5),
        check_out: Date.new(2018,2,7)}
      Hotel::Block.new(test_info).must_be_instance_of Hotel::Block
    end

    it 'has an id' do
      test_info = {rooms: Set[1, 2], check_in: Date.new(2018,3,5),
        check_out: Date.new(2018,3,7)}
      expected_id = Hotel::Block.get_all_blocks.size + 1
      manager = Hotel::Block.new(test_info)

      manager.must_respond_to :id
      manager.id.must_equal expected_id
    end

    it 'has an check in date' do
      test_info = {rooms: Set[1, 2], check_in: Date.new(2018,1,5),
        check_out: Date.new(2018,1,7)}
      manager = Hotel::Block.new(test_info)

      manager.must_respond_to :check_in
      manager.check_in.must_equal test_info[:check_in]
    end

    it 'has an check out date' do
      test_info = {rooms: Set[1, 2], check_in: Date.new(2018,1,9),
        check_out: Date.new(2018,1,11)}
      manager = Hotel::Block.new(test_info)

      manager.must_respond_to :check_out
      manager.check_out.must_equal test_info[:check_out]
    end

  
    #
    # it 'has an id' do
    #   @manager.must_respond_to :id
    #   expected_id = Hotel::Block.get_all_blocks.size + 1
    #   Hotel::Block.new(@test_info).id.must_equal expected_id
    # end
    # it 'throw error if invalid id' do
    #   proc {
    #     # @test_info[:id] = nil
    #     manager = Hotel::Block.new(@test_info)
    #   }.must_raise ArgumentError
    # end
  end # end of 'Initializer'

  describe 'Initializer' do


  end

end



  # TestDates = Struct.new(:check_in, :check_out)
  #
  # describe 'Initializer' do
  #   it 'is an instance of HotelManager' do
  #     manager = Hotel::HotelManager.new
  #     manager.must_be_instance_of Hotel::HotelManager
  #   end
  #
  #   it 'creates an empty list of reservations' do
  #     manager = Hotel::HotelManager.new
  #     manager.must_respond_to :get_reservations
  #     manager.get_reservations.must_be_kind_of Array
  #   end
  # end # end of 'Initializer'
  #
  #
  # # From module
  # describe 'Get Reservations' do
  #   before do
  #     @manager = Hotel::HotelManager.new
  #   end
  #
  #   it 'must return a list' do
  #     @manager.must_respond_to :get_reservations
  #     @manager.get_reservations.must_be_kind_of Array
  #   end
  #
  #   it 'gets a list of reservations' do
  #     @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) # not empty
  #     @manager.get_reservations.each { |res| res.must_respond_to :check_in }
  #     @manager.get_reservations.each { |res| res.must_respond_to :check_out }
  #   end
  #
  #   it 'must preserves the original list' do
  #     @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) # not empty
  #     room = @manager.get_reservations.last
  #     @manager.get_reservations.pop
  #     @manager.get_reservations.last.must_equal room
  #   end
  #
  # end
  #
  # describe 'Get Reservations on Date' do
  #   before do
  #     @manager = Hotel::HotelManager.new
  #     @in_range = TestDates.new(Date.new(2018,2,3), Date.new(2018,2,5))
  #     @out_of_range = TestDates.new(Date.new(2018,2,9), Date.new(2018,2,12))
  #     @manager.reserve_room(@in_range.check_in, @in_range.check_out)
  #     @manager.reserve_room(@out_of_range.check_in, @out_of_range.check_out)
  #   end
  #
  #   it 'returns a list of reservation' do
  #     @manager.must_respond_to :get_reservations_on_date
  #     @manager.get_reservations_on_date(Date.new(2018,2,5)).must_be_kind_of Array
  #   end
  #
  #   it 'returns only the reservation on that date' do
  #     res_list = @manager.get_reservations_on_date(Date.new(2018,2,4))
  #     res_list.size.must_equal 1
  #     res_list.first.check_in.must_equal @in_range.check_in
  #     res_list.first.check_out.must_equal @in_range.check_out
  #
  #     res_list = @manager.get_reservations_on_date(Date.new(2018,2,3))
  #     res_list.size.must_equal 1
  #     res_list.first.check_in.must_equal @in_range.check_in
  #     res_list.first.check_out.must_equal @in_range.check_out
  #   end
  #
  #   it 'returns returns multiple reservations' do
  #     @manager.reserve_room(Date.new(2018,2,1), Date.new(2018,2,7))
  #     res_list = @manager.get_reservations_on_date(Date.new(2018,2,4))
  #     res_list.size.must_equal 2
  #     res_list.last.check_out.must_equal Date.new(2018,2,7)
  #   end
  #
  #   it 'ignores reservations not on date' do
  #     #check_out overlaps but program does not considered an actual conflict
  #     res_list = @manager.get_reservations_on_date(Date.new(2018,2,5))
  #     res_list.must_equal []
  #
  #     res_list = @manager.get_reservations_on_date(Date.new(2018,2,2))
  #     res_list.must_equal []
  #   end
  #
  #   it 'throws error if invalid date value' do
  #     proc {
  #       @manager.get_reservations_on_date("not a date!")
  #     }.must_raise StandardError
  #   end
  # end
  #
  # describe 'Get Reservations In Date Range' do
  #   before do
  #     @manager = Hotel::HotelManager.new
  #     @in_range1 = TestDates.new(Date.new(2018,2,3), Date.new(2018,2,5))
  #     @in_range2 = TestDates.new(Date.new(2018,2,2), Date.new(2018,2,4))
  #     @out_of_range = TestDates.new(Date.new(2018,2,9), Date.new(2018,2,12))
  #     @manager.reserve_room(@in_range1.check_in, @in_range1.check_out)
  #     @manager.reserve_room(@in_range2.check_in, @in_range2.check_out)
  #     @manager.reserve_room(@out_of_range.check_in, @out_of_range.check_out)
  #   end
  #
  #   it 'returns a list of reservation' do
  #     @manager.must_respond_to :get_reservations_in_date_range
  #     @manager.get_reservations_in_date_range(Date.new(2018,2,4),
  #       Date.new(2018,2,5)).must_be_kind_of Array
  #   end
  #
  #   it 'returns only the reservation on that date' do
  #     res_list = @manager.get_reservations_in_date_range(Date.new(2018,2,4),
  #       Date.new(2018,2,5))
  #     res_list.size.must_equal 1
  #     res_list.first.check_in.must_equal @in_range1.check_in
  #     res_list.first.check_out.must_equal @in_range1.check_out
  #   end
  #
  #   it 'returns returns multiple reservations' do
  #     res_list = @manager.get_reservations_in_date_range(Date.new(2018,2,3),
  #       Date.new(2018,2,5))
  #     res_list.size.must_equal 2
  #     res_list.first.check_in.must_equal @in_range1.check_in
  #     res_list.first.check_out.must_equal @in_range1.check_out
  #     res_list.last.check_in.must_equal @in_range2.check_in
  #     res_list.last.check_out.must_equal @in_range2.check_out
  #   end
  #
  #   it 'ignores reservations not on date' do
  #     #check_out overlaps but program does not considered an actual conflict
  #     res_list = @manager.get_reservations_in_date_range(Date.new(2018,2,5),
  #       Date.new(2018,2,7))
  #     res_list.must_equal []
  #
  #     res_list = @manager.get_reservations_in_date_range(Date.new(2018,2,6),
  #       Date.new(2018,2,7))
  #     res_list.must_equal []
  #   end
  #
  #   it 'throws error if invalid date value' do
  #     proc {
  #       @manager.get_reservations_in_date_range("not date!", Date.new(2018,2,6))
  #     }.must_raise StandardError
  #
  #     proc {
  #       @manager.get_reservations_in_date_range(Date.new(2018,2,6), Date.new(2018,2,5))
  #     }.must_raise StandardError
  #   end
  # end
  #
  # describe 'Reserve Room' do
  #   before do
  #     @manager = Hotel::HotelManager.new
  #   end
  #
  #   it 'reserves a room' do
  #     @manager.must_respond_to :reserve_room
  #     original_num_of_res = @manager.get_reservations.length
  #     @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
  #     @manager.get_reservations.length.must_equal original_num_of_res + 1
  #   end
  #
  #   # Statistically unlikely to pass when it should fail but this is possible
  #   it 'only reserves available rooms' do
  #     20.times { @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) }
  #     reserved_rooms = @manager.get_reservations.collect { |res| res.room }.sort!
  #     reserved_rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
  #       15, 16, 17, 18, 19, 20]
  #   end
  #
  #   it 'throws ArgumentError when try to reserve when no rooms' do
  #     20.times { @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) }
  #     proc {
  #       @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
  #     }.must_raise ArgumentError
  #   end
  #
  #   it 'throws error if invalid date value' do
  #     proc {
  #       @manager.reserve_room("not date!", Date.new(2018,2,6))
  #     }.must_raise ArgumentError
  #
  #     proc {
  #       @manager.reserve_room(Date.new(2018,2,6), Date.new(2018,2,5))
  #     }.must_raise ArgumentError
  #   end
  #
  # end
  #
  # describe 'Get Rooms' do
  #   before do
  #     @manager = Hotel::HotelManager.new
  #   end
  #
  #   it 'returns a list of rooms' do
  #     @manager.must_respond_to :get_rooms
  #     @manager.get_rooms.must_be_kind_of Array
  #     @manager.get_rooms.size.must_equal 20
  #   end
  #
  #   it 'assigns room number' do
  #     room_num_list = @manager.get_rooms
  #     room_num_list.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
  #       15, 16, 17, 18, 19, 20]
  #   end
  #
  #   it 'preserves the original list of rooms' do
  #     @manager.get_rooms.pop
  #     @manager.get_rooms.size.must_equal 20
  #     @manager.get_rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
  #       14, 15, 16, 17, 18, 19, 20]
  #   end
  #
  # end
  #
  # # From module
  # describe 'Get Available Rooms' do
  #
  #   before do
  #     @manager = Hotel::HotelManager.new
  #   end
  #
  #   it 'gets a list of available rooms' do
  #     @manager.must_respond_to :get_available_rooms
  #     available_rooms =
  #       @manager.get_available_rooms(Date.new(2018,2,3), Date.new(2018,2,5))
  #     available_rooms.must_be_kind_of Array
  #     available_rooms.must_equal @manager.get_rooms
  #   end
  #
  #   it 'only gets rooms that are available' do
  #     rooms_before = @manager.get_available_rooms(Date.new(2018,2,3), Date.new(2018,2,5))
  #     @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
  #     rooms_after = @manager.get_available_rooms(Date.new(2018,2,3),
  #       Date.new(2018,2,5))
  #
  #     rooms_after.size.must_equal rooms_before.size - 1
  #   end
  #
  #
  #   it 'throws error if invalid date value' do
  #     proc {
  #       @manager.reserve_room("not date!", Date.new(2018,2,6))
  #     }.must_raise ArgumentError
  #
  #     proc {
  #       @manager.reserve_room(Date.new(2018,2,6), Date.new(2018,2,5))
  #     }.must_raise ArgumentError
  #   end


#   describe 'Initializer' do
#     before do
#       @initial_room_number = [1, 2, 3, 4]
#       @initial_check_in = Date.new(2018,2,3)
#       @initial_check_out = Date.new(2018,2,5)
#       @initial_rate = 200.0
#
#       @block_info = {
#         room: @initial_room_number,
#         check_in: @initial_check_in,
#         check_out: @initial_check_out,
#         # rate: @initial_rate
#       }
#       @reservation = Hotel::Reservation.new(@reservation_info)
#       @cost = 200.0 * 2
#     end
#
#     it 'is an instance of Reservation' do
#       @reservation.must_be_instance_of Hotel::Reservation
#     end
#
#     it 'has a room number' do
#       @reservation.must_respond_to :room
#       @reservation.room.must_be_kind_of Integer
#       @reservation.room.must_equal @initial_room_number
#     end
#
#     it 'has a check-in date' do
#       @reservation.must_respond_to :check_in
#       @reservation.check_in.must_be_kind_of Date
#       @reservation.check_in.must_equal @initial_check_in
#     end
#
#     it 'has a check-out date' do
#       @reservation.must_respond_to :check_out
#       @reservation.check_out.must_be_kind_of Date
#       @reservation.check_out.must_equal @initial_check_out
#     end
#
#
#     it 'has a cost' do
#       @reservation.must_respond_to :cost
#       @reservation.cost.must_be_kind_of Float
#       @reservation.cost.must_equal @cost
#     end
#
#     it 'throws an error is check-in is not a date' do
#       proc {
#         @reservation_info[:check_in] = 'I am not a check-in date.'
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#       proc {
#         @reservation_info[:check_in] = nil
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#     end
#
#     it 'throws an error is check-out is not a date' do
#       proc {
#         @reservation_info[:check_out] = 'I am not a check-out date.'
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#       proc {
#         @reservation_info[:check_out] = nil
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#     end
#
#     it 'throws an error if check-in is the same day as check-out' do
#       proc {
#         @reservation_info[:check_in] = Date.new(2018,2,5)
#         @reservation_info[:check_out] = Date.new(2018,2,5)
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#     end
#
#     it 'throws an error if check-in is after check-out' do
#       proc {
#         @reservation_info[:check_in] = Date.new(2018,2,5)
#         @reservation_info[:check_out] = Date.new(2018,2,4)
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#     end
#   end # end of Initializer
#
# end # end of Reservation
