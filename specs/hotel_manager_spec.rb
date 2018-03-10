require_relative 'spec_helper'

describe 'HotelManager class' do

  describe 'Initializer' do
    before do
      @manager = Hotel::HotelManager.new
    end
  #   it 'is an instance of Room' do
  #     @room.must_be_instance_of Hotel::Room
  #   end
  #
  #   it 'has a room number' do
  #     @room.must_respond_to :number
  #     @room.number.must_be_kind_of Integer
  #     @room.number.must_equal 1
  #   end
  #
  #   it 'throws error if invalid id' do
  #     proc { Hotel::Room.new("foo") }.must_raise ArgumentError
  #     proc { Hotel::Room.new(21) }.must_raise ArgumentError
  #     proc { Hotel::Room.new(0) }.must_raise ArgumentError
  #   end
  #
  #   it 'has a reservations array' do
  #     @room.must_respond_to :reservations
  #     @room.reservations.must_be_kind_of Array
  #     @room.reservations.must_equal []
  #   end
  #
  #   it 'returns a copy of reservations' do
  #     reservation_info = {
  #       id: 1,
  #       room_number: 3,
  #       check_in: Date.new(2018,2,3),
  #       check_out: Date.new(2018,2,5)
  #     }
  #     reservation = Hotel::Reservation.new(reservation_info)
  #
  #     @room.add_reservation(reservation)
  #     @room.reservations.pop
  #     @room.reservations.must_equal [reservation]
  #   end
  # end # end of 'Initializer'
  #
  # # 'add_reservation(reservation)' adds a reservation to reservations if the
  # # reservation is a valid Reservation.
  # describe 'Add Reservation' do
  #   before do
  #     @room = Hotel::Room.new(3)
  #     reservation_info = {
  #       id: 1,
  #       room_number: 3,
  #       check_in: Date.new(2018,2,3),
  #       check_out: Date.new(2018,2,5)
  #     }
  #     @reservation = Hotel::Reservation.new(reservation_info)
  #
  #     @room.add_reservation(@reservation)
  #   end
  #
  #   it 'adds a new reservation to reservations' do
  #     @room.reservations.must_equal [@reservation]
  #   end
  #
  #   it 'throws error if the reservation is not a Reservation' do
  #     proc { @room.add_reservation("foo") }.must_raise ArgumentError
  #   end
  #
  #   it 'throws error if not available for reservation' do
  #     proc {
  #       new_reservation = Hotel::Reservation.new(id: 14, room_number: 3,
  #       check_in: Date.new(2018,2,1), check_out: Date.new(2018,2,5))
  #       @room.add_reservation(new_reservation)
  #     }.must_raise ArgumentError
  #   end
  #
  #   # it 'throws error if the reservation room is not \'this\'' do
  #   #   # TODO: what's up with this? IE, the circular logic
  #   # end
  #
  # end # end of 'Add Reservation'
  #
  # describe 'Is Available?' do
  #   before do
  #     @room = Hotel::Room.new(3)
  #     @room.add_reservation(Hotel::Reservation.new({id: 21, room_number: 12,
  #       check_in: Date.new(2018,2,3), check_out: Date.new(2018,2,8)}))
  #     @room.add_reservation(Hotel::Reservation.new({id: 83, room_number: 12,
  #       check_in: Date.new(2018,2,12), check_out: Date.new(2018,2,17)}))
  #   end
  #
  #   it 'returns true if is available in range' do
  #     @room.is_available?(Date.new(2018,2,9), Date.new(2018,2,11)).must_equal true
  #   end
  #
  #   it 'returns true if available on another reservation end date' do
  #     @room.is_available?(Date.new(2018,2,8), Date.new(2018,2,11)).must_equal true
  #   end
  #
  #   it 'returns true if end date is on another reservation start date' do
  #     @room.is_available?(Date.new(2018,2,9), Date.new(2018,2,12)).must_equal true
  #   end
  #
  #   it 'returns true of starts/ends overlap with two reservations' do
  #     @room.is_available?(Date.new(2018,2,8), Date.new(2018,2,12)).must_equal true
  #   end
  #
  #   it 'returns false if overlaps on non-start/end dates' do
  #     @room.is_available?(Date.new(2018,2,9), Date.new(2018,2,13)).must_equal false
  #   end
  #
  #   it 'returns false if overlaps on non-start/end dates' do
  #     @room.is_available?(Date.new(2018,2,7), Date.new(2018,2,11)).must_equal false
  #   end
  #
  #   # it 'throws error if the reservation is not a Reservation' do
  #   #   proc {
  #   #     @room.is_available?("foo", Date.new(2018,2,11))
  #   #   }.must_raise ArgumentError
  #   # end
  # end # end of 'Is Available?'

end # end of 'Room'
