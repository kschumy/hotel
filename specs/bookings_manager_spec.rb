require_relative 'spec_helper'

describe "BookingsManager class" do
  ROOM_RATE = 200.0
  NUM_OF_ROOMS = 20

  describe "Initializer" do
    it "is an instance of BookingsManager" do
      manager = Hotel::BookingsManager.new
      manager.must_be_kind_of Hotel::BookingsManager
    end

  end
end
