# require_relative 'reservation_dates'
require_relative 'reservable'

module Hotel
  class Block < Reservation

    # extend DatesRangeModule

    # include ReservationDates
    include Reservable

    BLOCK_RATE = RATE * 0.8

    @@all_blocks = []

    attr_reader :id, :room, :check_in, :check_out, :cost

    def initialize(initial_info)
      super
      @rooms = initial_info[:rooms]
      check_if_valid_dates(@start_date, @end_date)
      # @check_in = initial_info[:check_in]
      # @check_out = initial_info[:check_out]
      @cost = get_duration(@check_in, @check_out) * BLOCK_RATE
      @@all_blocks << self
    end

    def self.get_available_rooms(block_id)
      return get_block(block_id).get_rooms - get_reservations.collect { |res| res.room }
    end

    def get_rooms
      return @rooms.dup
    end

    def self.get_block(block_id)
      return @@all_blocks.select { |block| block.id }
    end


    private


  end
end
