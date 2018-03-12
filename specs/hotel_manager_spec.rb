require_relative 'spec_helper'

describe 'HotelManager class' do

  describe 'Initializer' do
    # before do
    #   @manager = Hotel::HotelManager.new
    # end

    it 'is an instance of HotelManager' do
      manager = Hotel::HotelManager.new
      manager.must_be_instance_of Hotel::HotelManager
    end
  end # end of 'Initializer'

  describe 'Get Rooms' do
    before do
      @manager = Hotel::HotelManager.new
    end

    it 'returns a list of rooms' do
      @manager.must_respond_to :rooms
      @manager.rooms.must_be_kind_of Array
      @manager.rooms.size.must_equal 20
      (@manager.rooms.all? { |room| room.must_be_kind_of Hotel::Room
        }).must_equal true
    end

    it 'assigns room number' do
      room_num_list = @manager.rooms.collect { |room| room.number }
      room_num_list.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20]
    end

    it 'preserves the original list of rooms' do
      @manager.rooms.pop
      @manager.rooms.size.must_equal 20
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

    it 'reserves the first available room' do
      first_room_res_before = @manager.rooms.first.reservations.last # should be nil
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
      first_room_res_after =  @manager.rooms.first.reservations.last
      reservation_lists_match = first_room_res_before == first_room_res_after
      reservation_lists_match.must_equal false
    end

  end

  describe 'Get Reservations' do
    before do
      @manager = Hotel::HotelManager.new
    end

    it 'gets a list of reservations' do
      @manager.must_respond_to :get_reservations
      @manager.get_reservations.must_be_kind_of Array
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5)) # not empty

      (@manager.get_reservations.all? { |res| res.must_be_kind_of Hotel::Reservation
        }).must_equal true
    end

  end


  describe 'Get Available Rooms' do

    before do
      @manager = Hotel::HotelManager.new
    end

    it 'gets a list of available rooms' do
      @manager.must_respond_to :get_available_rooms
      available_rooms =
        @manager.get_available_rooms(Date.new(2018,2,3), Date.new(2018,2,5))
      available_rooms.must_be_kind_of Array
      available_rooms.must_equal @manager.rooms
    end

    it 'only gets rooms that are available' do
      rooms_before = @manager.get_available_rooms(Date.new(2018,2,3),
        Date.new(2018,2,5))
      room = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
      rooms_after = @manager.get_available_rooms(Date.new(2018,2,3),
        Date.new(2018,2,5))

      rooms_after.size.must_equal rooms_before.size - 1
    end

  end




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
