require_relative 'spec_helper'

describe "Room class" do

  describe "Initializer" do
    it "is an instance of Room" do
      room = Hotel::Room.new(1)
      room.must_be_instance_of Hotel::Room
    end

    it "has a room number" do
      room = Hotel::Room.new(1)

      room.must_respond_to :number
      room.number.must_be_kind_of Integer
      room.number.must_equal 1
    end

    it "throws error if invalid id" do
      proc { Hotel::Room.new("foo") }.must_raise ArgumentError
      proc { Hotel::Room.new(21) }.must_raise ArgumentError
      proc { Hotel::Room.new(0) }.must_raise ArgumentError
    end



  end
end
