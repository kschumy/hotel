require_relative 'spec_helper'

describe "BookingsManager class" do
  before do
    @manager = Hotel::BookingsManager.new
  end

  describe "Initializer" do
    it "is an instance of BookingsManager" do
      @manager.must_be_instance_of Hotel::BookingsManager
    end

    it "creates a list of rooms (numbers)" do
      @manager.must_respond_to :rooms
      @manager.rooms.must_be_kind_of Array
      @manager.rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
        14, 15, 16, 17, 18, 19, 20]
    end

    it "creates a empty list for reservations" do
      @manager.must_respond_to :reservations
      @manager.reservations.must_be_kind_of Array
      @manager.reservations.must_equal []
    end
  end

  describe "Reserve Room" do
    before do
      @initial_id = 42
      @initial_room_number = 1
      @initial_check_in = Date.new(2018,2,3)
      @initial_check_out = Date.new(2018,2,5)

      @reservation_info = {
        id: @initial_id,
        room_number: @initial_room_number,
        check_in_date: @initial_check_in,
        check_out_date: @initial_check_out
      }
      # @reservation = Hotel::Reservation.new(@reservation_info)
    end

    it "is an returns a new Reservation" do
      reservation = @manager.reserve_room(@initial_check_in, @initial_check_out)

      reservation.must_be_instance_of Hotel::Reservation
      reservation.check_in_date.must_equal @initial_check_in
      reservation.check_out_date.must_equal @initial_check_out
    end

    it "adds the new reservation to the reservations list" do
      num_of_reservations_before = @manager.reservations.length
      reservation = @manager.reserve_room(@initial_check_in, @initial_check_out)

      @manager.reservations.last.must_equal reservation
      @manager.reservations.length.must_equal (num_of_reservations_before + 1)
    end

  end

end
