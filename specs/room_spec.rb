require_relative 'spec_helper'

describe 'Room class' do

  describe 'Initializer' do
    before do
      @room = Hotel::Room.new(1)
    end

    it 'is an instance of Room' do
      @room.must_be_instance_of Hotel::Room
    end

    it 'has a room number' do
      @room.must_respond_to :number
      @room.number.must_be_kind_of Integer
      @room.number.must_equal 1
    end

    it 'throws error if invalid id' do
      proc { Hotel::Room.new("foo") }.must_raise ArgumentError
      proc { Hotel::Room.new(21) }.must_raise ArgumentError
      proc { Hotel::Room.new(0) }.must_raise ArgumentError
    end

    it 'has a reservations array' do
      @room.must_respond_to :reservations
      @room.reservations.must_be_kind_of Array
      @room.reservations.must_equal []
    end

    it 'returns a copy of reservations' do
      # TODO: completed when done
      # @room.reservations.must_equal []
    end
  end # end of 'Initializer'

  # 'add_reservation(reservation)' adds a reservation to reservations if the
  # reservation is a valid Reservation.
  describe 'Add Reservation' do
    before do
      @room = Hotel::Room.new(1)
    end

    it 'adds a new reservation to reservations' do

    end

    it 'throws error if the reservation is not a Reservation' do

    end

    # it 'throws error if the reservation room is not \'this\'' do
    #   # TODO: what's up with this? IE, the circular logic
    # end
    
  end # end of 'Add Reservation'

end # end of 'Room'
