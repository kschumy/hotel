require_relative 'spec_helper'

describe "BookingsManager class" do
  ROOM_RATE = 200.0
  NUM_OF_ROOMS = 20

  describe "Initializer" do
    it "is an instance of BookingsManager" do
      manager = Hotel::BookingsManager.new
      manager.must_be_instance_of Hotel::BookingsManager
    end

    it "creates a list of rooms (numbers)" do
      manager = Hotel::BookingsManager.new

      manager.must_respond_to :rooms
      manager.rooms.must_be_kind_of Array
      manager.rooms.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
        14, 15, 16, 17, 18, 19, 20]
    end

  end
end
