require_relative 'spec_helper'

describe 'HotelManager class' do

  TestDates = Struct.new(:check_in, :check_out)

  describe 'Initializer' do
    it 'is an instance of HotelManager' do
      manager = Hotel::HotelManager.new
      manager.must_be_instance_of Hotel::HotelManager
    end

    it 'creates an empty list of reservations' do
      manager = Hotel::HotelManager.new
      manager.must_respond_to :get_reservations
      manager.get_reservations.must_be_kind_of Array
    end
  end # end of 'Initializer'


  # From module
  describe 'Get Reservations' do
    before do
      @manager = Hotel::HotelManager.new
    end

    it 'must return a list' do
      @manager.must_respond_to :get_reservations
      @manager.get_reservations.must_be_kind_of Array
    end

    it 'gets a list of reservations' do
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) # not empty
      @manager.get_reservations.each { |res| res.must_respond_to :check_in }
      @manager.get_reservations.each { |res| res.must_respond_to :check_out }
    end

    it 'must preserves the original list' do
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) # not empty
      room = @manager.get_reservations.last
      @manager.get_reservations.pop
      @manager.get_reservations.last.must_equal room
    end

  end

  describe 'Get Reservations on Date' do
    before do
      @manager = Hotel::HotelManager.new
      @in_range = TestDates.new(Date.new(2018,2,3), Date.new(2018,2,5))
      @out_of_range = TestDates.new(Date.new(2018,2,9), Date.new(2018,2,12))
      @manager.reserve_room(@in_range.check_in, @in_range.check_out)
      @manager.reserve_room(@out_of_range.check_in, @out_of_range.check_out)
    end

    it 'returns a list of reservation' do
      @manager.must_respond_to :get_reservations_on_date
      @manager.get_reservations_on_date(Date.new(2018,2,5)).must_be_kind_of Array
    end

    it 'returns only the reservation on that date' do
      res_list = @manager.get_reservations_on_date(Date.new(2018,2,4))
      res_list.size.must_equal 1
      res_list.first.check_in.must_equal @in_range.check_in
      res_list.first.check_out.must_equal @in_range.check_out

      res_list = @manager.get_reservations_on_date(Date.new(2018,2,3))
      res_list.size.must_equal 1
      res_list.first.check_in.must_equal @in_range.check_in
      res_list.first.check_out.must_equal @in_range.check_out
    end

    it 'returns returns multiple reservations' do
      @manager.reserve_room(Date.new(2018,2,1), Date.new(2018,2,7))
      res_list = @manager.get_reservations_on_date(Date.new(2018,2,4))
      res_list.size.must_equal 2
      res_list.last.check_out.must_equal Date.new(2018,2,7)
    end

    it 'ignores reservations not on date' do
      #check_out overlaps but program does not considered an actual conflict
      res_list = @manager.get_reservations_on_date(Date.new(2018,2,5))
      res_list.must_equal []

      res_list = @manager.get_reservations_on_date(Date.new(2018,2,2))
      res_list.must_equal []
    end

    it 'throws error if invalid date value' do
      proc {
        @manager.get_reservations_on_date("not a date!")
      }.must_raise StandardError
    end
  end

  describe 'Get Reservations In Date Range' do
    before do
      @manager = Hotel::HotelManager.new
      @in_range1 = TestDates.new(Date.new(2018,2,3), Date.new(2018,2,5))
      @in_range2 = TestDates.new(Date.new(2018,2,2), Date.new(2018,2,4))
      @out_of_range = TestDates.new(Date.new(2018,2,9), Date.new(2018,2,12))
      @manager.reserve_room(@in_range1.check_in, @in_range1.check_out)
      @manager.reserve_room(@in_range2.check_in, @in_range2.check_out)
      @manager.reserve_room(@out_of_range.check_in, @out_of_range.check_out)
    end

    it 'returns a list of reservation' do
      @manager.must_respond_to :get_reservations_in_date_range
      @manager.get_reservations_in_date_range(Date.new(2018,2,4),
        Date.new(2018,2,5)).must_be_kind_of Array
    end

    it 'returns only the reservation on that date' do
      res_list = @manager.get_reservations_in_date_range(Date.new(2018,2,4),
        Date.new(2018,2,5))
      res_list.size.must_equal 1
      res_list.first.check_in.must_equal @in_range1.check_in
      res_list.first.check_out.must_equal @in_range1.check_out
    end

    it 'returns returns multiple reservations' do
      res_list = @manager.get_reservations_in_date_range(Date.new(2018,2,3),
        Date.new(2018,2,5))
      res_list.size.must_equal 2
      res_list.first.check_in.must_equal @in_range1.check_in
      res_list.first.check_out.must_equal @in_range1.check_out
      res_list.last.check_in.must_equal @in_range2.check_in
      res_list.last.check_out.must_equal @in_range2.check_out
    end

    it 'ignores reservations not on date' do
      #check_out overlaps but program does not considered an actual conflict
      res_list = @manager.get_reservations_in_date_range(Date.new(2018,2,5),
        Date.new(2018,2,7))
      res_list.must_equal []

      res_list = @manager.get_reservations_in_date_range(Date.new(2018,2,6),
        Date.new(2018,2,7))
      res_list.must_equal []
    end

    it 'throws error if invalid date value' do
      proc {
        @manager.get_reservations_in_date_range("not date!", Date.new(2018,2,6))
      }.must_raise StandardError

      proc {
        @manager.get_reservations_in_date_range(Date.new(2018,2,6), Date.new(2018,2,5))
      }.must_raise StandardError
    end
  end

  describe 'Reserve Room' do
    before do
      @manager = Hotel::HotelManager.new
    end

    it 'reserves a room' do
      @manager.must_respond_to :reserve_room
      original_num_of_res = @manager.get_reservations.length
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
      @manager.get_reservations.length.must_equal original_num_of_res + 1
    end

    # Statistically unlikely to pass when it should fail but this is possible
    it 'only reserves available rooms' do
      20.times { @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) }
      reserved_rooms = @manager.get_reservations.collect { |res| res.room }.sort!
      reserved_rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20]
    end

    it 'throws ArgumentError when try to reserve when no rooms' do
      20.times { @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) }
      proc {
        @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
      }.must_raise ArgumentError
    end

    it 'throws error if invalid date value' do
      proc {
        @manager.reserve_room("not date!", Date.new(2018,2,6))
      }.must_raise ArgumentError

      proc {
        @manager.reserve_room(Date.new(2018,2,6), Date.new(2018,2,5))
      }.must_raise ArgumentError
    end

  end

  describe 'Get Rooms' do
    before do
      @manager = Hotel::HotelManager.new
    end

    it 'returns a list of rooms' do
      @manager.must_respond_to :get_rooms
      @manager.get_rooms.must_be_kind_of Array
      @manager.get_rooms.size.must_equal 20
    end

    it 'assigns room number' do
      room_num_list = @manager.get_rooms
      room_num_list.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20]
    end

    it 'preserves the original list of rooms' do
      @manager.get_rooms.pop
      @manager.get_rooms.size.must_equal 20
      @manager.get_rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
        14, 15, 16, 17, 18, 19, 20]
    end

  end

  # From module
  describe 'Get Available Rooms' do

    before do
      @manager = Hotel::HotelManager.new
    end

    it 'gets a list of available rooms' do
      @manager.must_respond_to :get_available_rooms
      available_rooms =
        @manager.get_available_rooms(Date.new(2018,2,3), Date.new(2018,2,5))
      available_rooms.must_be_kind_of Array
      available_rooms.must_equal @manager.get_rooms
    end

    it 'only gets rooms that are available' do
      rooms_before = @manager.get_available_rooms(Date.new(2018,2,3),
        Date.new(2018,2,5))
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
      rooms_after = @manager.get_available_rooms(Date.new(2018,2,3),
        Date.new(2018,2,5))

      rooms_after.size.must_equal rooms_before.size - 1
    end


    it 'throws error if invalid date value' do
      proc {
        @manager.reserve_room("not date!", Date.new(2018,2,6))
      }.must_raise ArgumentError

      proc {
        @manager.reserve_room(Date.new(2018,2,6), Date.new(2018,2,5))
      }.must_raise ArgumentError
    end


  end
  #



  #
  #   it 'has a reservations array' do
  #     @manager.must_respond_to :reservations
  #     @manager.reservations.must_be_kind_of Array
  #     @manager.reservations.must_equal []
  #   end
  #
  #   it 'returns a copy of reservations' do
  #     reservation_info = {
  #       id: 1
  #       room_number: 3
  #       check_in: Date.new(201823)
  #       check_out: Date.new(201825)
  #     }
  #     reservation = Hotel::Reservation.new(reservation_info)
  #
  #     @manager.add_reservation(reservation)
  #     @manager.reservations.pop
  #     @manager.reservations.must_equal [reservation]
  #   end
  #
  # # 'add_reservation(reservation)' adds a reservation to reservations if the
  # # reservation is a valid Reservation.
  # describe 'Add Reservation' do
  #   before do
  #     @manager = Hotel::Room.new(3)
  #     reservation_info = {
  #       id: 1
  #       room_number: 3
  #       check_in: Date.new(201823)
  #       check_out: Date.new(201825)
  #     }
  #     @reservation = Hotel::Reservation.new(reservation_info)
  #
  #     @manager.add_reservation(@reservation)
  #   end
  #
  #   it 'adds a new reservation to reservations' do
  #     @manager.reservations.must_equal [@reservation]
  #   end
  #
  #   it 'throws error if the reservation is not a Reservation' do
  #     proc { @manager.add_reservation("foo") }.must_raise ArgumentError
  #   end
  #
  #   it 'throws error if not available for reservation' do
  #     proc {
  #       new_reservation = Hotel::Reservation.new(id: 14 room_number: 3
  #       check_in: Date.new(201821) check_out: Date.new(201825))
  #       @manager.add_reservation(new_reservation)
  #     }.must_raise ArgumentError
  #   end

  #
  # end # end of 'Add Reservation'
  #
  # describe 'Is Available?' do
  #   before do
  #     @manager = Hotel::Room.new(3)
  #     @manager.add_reservation(Hotel::Reservation.new({id: 21 room_number: 12
  #       check_in: Date.new(201823) check_out: Date.new(201828)}))
  #     @manager.add_reservation(Hotel::Reservation.new({id: 83 room_number: 12
  #       check_in: Date.new(2018212) check_out: Date.new(2018217)}))
  #   end
  #
  #   it 'returns true if is available in range' do
  #     @manager.is_available?(Date.new(201829) Date.new(2018211)).must_equal true
  #   end
  #
  #   it 'returns true if available on another reservation end date' do
  #     @manager.is_available?(Date.new(201828) Date.new(2018211)).must_equal true
  #   end
  #
  #   it 'returns true if end date is on another reservation start date' do
  #     @manager.is_available?(Date.new(201829) Date.new(2018212)).must_equal true
  #   end
  #
  #   it 'returns true of starts/ends overlap with two reservations' do
  #     @manager.is_available?(Date.new(201828) Date.new(2018212)).must_equal true
  #   end
  #
  #   it 'returns false if overlaps on non-start/end dates' do
  #     @manager.is_available?(Date.new(201829) Date.new(2018213)).must_equal false
  #   end
  #
  #   it 'returns false if overlaps on non-start/end dates' do
  #     @manager.is_available?(Date.new(201827) Date.new(2018211)).must_equal false
  #   end
  #
  #   # it 'throws error if the reservation is not a Reservation' do
  #   #   proc {
  #   #     @manager.is_available?("foo" Date.new(2018211))
  #   #   }.must_raise ArgumentError
  #   # end
  # end # end of 'Is Available?'

end # end of 'Room'
