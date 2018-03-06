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

    it 'creates a empty list for reservations' do
      @manager.must_respond_to :reservations
      @manager.reservations.must_be_kind_of Array
      @manager.reservations.must_equal []
    end
  end # end Initializer

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
  end # end Reserve Room

  describe 'get_reservations_on_date' do
    it 'returns an empty list if no reservations on that date' do
      @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
    end

    it 'returns an list of reservations on that date' do
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
  end # end get_reservations_on_date

end # end BookingsManager
