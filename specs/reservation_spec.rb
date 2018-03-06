require_relative 'spec_helper'

describe "Reservation class" do

  describe "Initializer" do
    before do
      @initial_id = 42
      @initial_room_number = 1
      @initial_check_in = Date.new(2018,2,3)
      @initial_check_out = Date.new(2018,2,5)

      @reservation_info = {
        id: @initial_id,
        room_number: @initial_room_number,
        check_in: @initial_check_in,
        check_out: @initial_check_out
      }
      @reservation = Hotel::Reservation.new(@reservation_info)
    end

    it "is an instance of Reservation" do
      @reservation.must_be_instance_of Hotel::Reservation
    end

    it "has a reservation number" do
      @reservation.must_respond_to :id
      @reservation.id.must_be_kind_of Integer
      @reservation.id.must_equal @initial_id
    end

    it "has a room number" do
      @reservation.must_respond_to :room_number
      @reservation.room_number.must_be_kind_of Integer
      @reservation.room_number.must_equal @initial_room_number
    end

    it "has a check-in date" do
      @reservation.must_respond_to :check_in
      @reservation.check_in.must_be_kind_of Date
      @reservation.check_in.must_equal @initial_check_in
    end

    it "has a check-out date" do
      @reservation.must_respond_to :check_out
      @reservation.check_out.must_be_kind_of Date
      @reservation.check_out.must_equal @initial_check_out
    end

    it "throws an error is id is not an Integer" do
      proc {
        @reservation_info[:id] = "Look at me. I am the id now."
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
      proc {
        @reservation_info[:id] = nil
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error is id is less than 1" do
      proc {
        @reservation_info[:id] = 0
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error is check-in is not a date" do
      proc {
        @reservation_info[:check_in] = "I am not a check-in date."
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
      proc {
        @reservation_info[:check_in] = nil
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error is check-out is not a date" do
      proc {
        @reservation_info[:check_out] = "I am not a check-out date."
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
      proc {
        @reservation_info[:check_out] = nil
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error if check-in is the same day as check-out" do
      proc {
        @reservation_info[:check_in] = Date.new(2018,2,5)
        @reservation_info[:check_out] = Date.new(2018,2,5)
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error if check-in is after check-out" do
      proc {
        @reservation_info[:check_in] = Date.new(2018,2,5)
        @reservation_info[:check_out] = Date.new(2018,2,4)
        Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end
  end # end of Initializer

  describe "Get Cost" do
    before do
      @initial_id = 42
      @initial_room_number = 1
      @initial_check_in = Date.new(2018,2,3)
      @initial_check_out = Date.new(2018,2,5)

      @reservation_info = {
        id: @initial_id,
        room_number: @initial_room_number,
        check_in: @initial_check_in,
        check_out: @initial_check_out
      }
      @reservation = Hotel::Reservation.new(@reservation_info)
    end

    it 'returns the cost' do
      @reservation.get_cost.must_equal 200.0 * 2
    end
  end # end of Get Cost


end # end of Reservation
