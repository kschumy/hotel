require_relative 'reservation_dates'
require_relative 'reservable'

module Hotel
  class Block
    include DatesRangeModule
    include Reservable

    BLOCK_RATE = RATE * 0.8
    MAX_BLOCK_SIZE = 5

    @@all_blocks = []

    attr_reader :id, :check_in, :check_out

    def initialize(initial_info)
      @id = @@all_blocks.size + 1
      @rooms = check_rooms(initial_info.fetch(:rooms))
      @check_in = initial_info[:check_in]
      @check_out = initial_info[:check_out]

      check_if_valid_dates(initial_info[:check_in], initial_info[:check_out])
      @@all_blocks << self
    end

    def get_rooms
      return @rooms.dup
    end

    def self.get_block(block_id)
      return get_all_blocks.select { |block| block.id }
    end

    def self.get_all_blocks
      return @@all_blocks.dup
    end

    def reserve_room_in_block(check_in, check_out)
      raise ArgumentError.new("invalid dates") if !has_same_range?(other)
      reserve_room_with_info(get_new_reservation_info(check_in, check_out))
    end


    private

    def check_rooms(initial_rooms)
      if !initial_rooms.size.between?(1,5) || initial_rooms.any?(nil)
        raise ArgumentError.new(i"nvalid initial rooms")
      end
      return initial_rooms.to_set
    end

    def check_if_double_booked
      @@blocks.each do |block|
        raise ArgumentError.new if self.conflicts_with?(block) ||
        self.rooms { |room| block.rooms.include?(room) }
      end
    end

  end
end
