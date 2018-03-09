require_relative 'spec_helper'

describe 'Room class' do

  describe 'Initializer' do
    before do
      @manager = HotelSystem::RoomsManager.new
    end

    it 'is an instance of Room' do
      @manager.must_be_instance_of HotelSystem::RoomsManager
    end
  end
end
