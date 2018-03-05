require_relative 'spec_helper'

describe "Room class" do

  describe "Initializer" do
    it "is an instance of Room" do
      room = Hotel::Room.new
      room.must_be_instance_of Hotel::Room
    end

    # it "creates a list of rooms (numbers)" do
    #   manager = Hotel::BookingsManager.new
    #
    #   manager.must_respond_to :rooms
    #   manager.rooms.must_be_kind_of Array
    #   manager.rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
    #     14, 15, 16, 17, 18, 19, 20]
    # end

  end
end
