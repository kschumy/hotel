require_relative 'spec_helper'

describe "Reservation class" do

  describe "Initializer" do
    before do
      @initial_id = 42
      @initial_room_number = 1
      @initial_check_in_date = Date.new(2018,2,3)
      @initial_check_out_date = Date.new(2018,2,5)

      @reservation_info = {
        id: @initial_id,
        room_number: @initial_room_number,
        check_in_date: @initial_check_in_date,
        check_out_date: @initial_check_out_date
      }

      @reservation = Hotel::Reservation.new(@reservation_info)
    end

    it "is an instance of Reservation" do
      new_reservation = Hotel::Reservation.new(@reservation_info)
      new_reservation.must_be_instance_of Hotel::Reservation
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
      @reservation.check_in_date.must_equal @initial_check_in_date
    end

    it "has a check-out date" do
      @reservation.must_respond_to :check_out_date
      @reservation.check_out_date.must_be_kind_of Date
      @reservation.check_out_date.must_equal @initial_check_out_date
    end

  end
end
