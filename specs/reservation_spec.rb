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
        check_in_date: @initial_check_in,
        check_out_date: @initial_check_out
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
      @reservation.must_respond_to :check_in_date
      @reservation.check_in_date.must_be_kind_of Date
      @reservation.check_in_date.must_equal @initial_check_in
    end

    it "has a check-out date" do
      @reservation.must_respond_to :check_out_date
      @reservation.check_out_date.must_be_kind_of Date
      @reservation.check_out_date.must_equal @initial_check_out
    end

    it "throws an error is id is not an Integer" do
      proc {
        @reservation_info[:id] = "Look at me. I am the id now."
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
      proc {
        @reservation_info[:id] = nil
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error is id is less than 1" do
      proc {
        @reservation_info[:id] = 0
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error is check-in is not a date" do
      proc {
        @reservation_info[:check_in_date] = "I am not a check-in date."
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
      proc {
        @reservation_info[:check_in_date] = nil
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error is check-out is not a date" do
      proc {
        @reservation_info[:check_out_date] = "I am not a check-out date."
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
      proc {
        @reservation_info[:check_out_date] = nil
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error if check-in is the same day as check-out" do
      proc {
        @reservation_info[:check_in_date] = Date.new(2018,2,5)
        @reservation_info[:check_out_date] = Date.new(2018,2,5)
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

    it "throws an error if check-in is after check-out" do
      proc {
        @reservation_info[:check_in_date] = Date.new(2018,2,5)
        @reservation_info[:check_out_date] = Date.new(2018,2,4)
        new_reservation = Hotel::Reservation.new(@reservation_info)
      }.must_raise ArgumentError
    end

  end
end
