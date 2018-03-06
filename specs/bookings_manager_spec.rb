require_relative 'spec_helper'

describe 'BookingsManager class' do
  before do
    @manager = Hotel::BookingsManager.new
  end

  describe 'Initializer' do
    it 'is an instance of BookingsManager' do
      @manager.must_be_instance_of Hotel::BookingsManager
    end

    it 'creates a list of rooms (numbers)' do
      @manager.must_respond_to :rooms
      @manager.rooms.must_be_kind_of Array
      @manager.rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
        14, 15, 16, 17, 18, 19, 20]
    end

    it 'does not return the original list of rooms' do
      @manager.rooms.pop
      @manager.rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
        14, 15, 16, 17, 18, 19, 20]
    end

    it 'creates a empty list for reservations' do
      @manager.must_respond_to :reservations
      @manager.reservations.must_be_kind_of Array
      @manager.reservations.must_equal []
    end

    it 'does not return the original list of reservations' do
      new_room = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))

      @manager.reservations.pop
      @manager.reservations.must_equal [new_room]
    end
  end # end of 'Initializer'

  describe 'Reserve Room' do
    before do
      @initial_check_in = Date.new(2018,2,3)
      @initial_check_out = Date.new(2018,2,5)
    end

    it 'is an returns a new Reservation' do
      reservation = @manager.reserve_room(@initial_check_in, @initial_check_out)
      reservation.must_be_instance_of Hotel::Reservation
      reservation.check_in.must_equal @initial_check_in
      reservation.check_out.must_equal @initial_check_out
    end

    it 'adds the new reservation to the reservations list' do
      num_of_reservations_before = @manager.reservations.length
      reservation = @manager.reserve_room(@initial_check_in, @initial_check_out)
      @manager.reservations.last.must_equal reservation
      @manager.reservations.length.must_equal (num_of_reservations_before + 1)
    end

    it 'sets the reservation numbers by incrementing by one' do
      reservation = @manager.reserve_room(@initial_check_in, @initial_check_out)
      reservation.id.must_equal 1
      reservation2 = @manager.reserve_room(@initial_check_in, @initial_check_out)
      reservation2.id.must_equal 2
    end
  end # end of 'Reserve Room'

  describe 'Get Reservations On Date' do
    it 'returns an empty list if no reservations on date' do
      @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4)) # before
      @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
    end

    it 'returns an list of reservations on date' do
      res1 = @manager.reserve_room(Date.new(2018,2,5), Date.new(2018,2,8))
      res2 = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,6))
      res_on_date = @manager.get_reservations_on_date(Date.new(2018,2,5))

      res_on_date.must_equal [res1, res2]
    end

    it 'only includes reservations that overlap with date' do
      res1 = @manager.reserve_room(Date.new(2018,2,5), Date.new(2018,2,8))
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4)) # before
      res2 = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,6))
      @manager.reserve_room(Date.new(2018,2,6), Date.new(2018,2,7)) # after
      res_on_date = @manager.get_reservations_on_date(Date.new(2018,2,5))

      res_on_date.must_equal [res1, res2]
    end

    it 'does not include reservations that end on the date' do
      @manager.reserve_room(Date.new(2018,2,2), Date.new(2018,2,5))
      @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
    end

    it "throws an ArgumentError for an invalid date" do
      proc { @manager.get_reservations_on_date("foo") }.must_raise ArgumentError
    end
  end # end of 'Get Reservations On Date'

  describe 'Get Reservation Cost' do
    it 'the cost of a the reservation' do
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4))
      @manager.get_reservation_cost(1).must_equal 200.0
    end

    it 'the cost of a the reservation' do
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4))
      # cost = @manager.get_reservation_cost(1)
      # cost *= 2
      @manager.get_reservation_cost(1).must_equal 200.0
    end

    it 'the cost of a the reservation' do
      @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4))
      proc { @manager.get_reservation_cost(2) }.must_raise ArgumentError
      proc { @manager.get_reservation_cost("foo") }.must_raise ArgumentError
    end
  end # end of 'Get Reservation Cost'

end # end of 'BookingsManager'
