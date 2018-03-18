require_relative 'reservation_dates'
require_relative 'reservable'

module Hotel
  class Block
    include DatesRangeModule
    # include Reservable

    BLOCK_RATE = RATE * 0.8
    MAX_BLOCK_SIZE = 5

    @@all_blocks = []

    attr_reader :id, :check_in, :check_out

    def initialize(initial_info)
      @id = @@all_blocks.size + 1
      @check_in = initial_info[:check_in]
      @check_out = initial_info[:check_out]
      @reservations = []
      # check_if_valid_dates(initial_info[:check_in], initial_info[:check_out])
      build_initial_empty_reservations(initial_info.fetch(:rooms))
      @@all_blocks << self
    end

    def get_rooms
      return @reservations.select { |room| room.id }
      # return @reservations.select { |reservation| reservation.room }.dup
    end

    def self.get_block(block_id)
      return get_all_blocks.select { |block| block.id }
    end

    def self.get_all_blocks
      return @@all_blocks.dup
    end

    def reserve_room
      # raise ArgumentError.new("invalid dates") if !has_same_range?(other)
      reserve_room_with_info(get_new_reservation_info(check_in, check_out))
    end


    private

    def build_initial_empty_reservations(rooms)
      check_rooms(rooms)
      check_if_double_booked(rooms)
      # puts rooms.inspect
      # HeldRoom = Struct.new(:room, check_in: @check_in, check_out:@check_out)
      rooms.each { |room| @reservations << Reservation.new(check_in: @check_in,
        check_out: @check_out, room: room) }
        # res_info = get_new_reservation_info(@check_in, @check_out)
        # @reservations << Reservation.new(res_info)
         # Struct.new(*res_info.keys).new(*res_info.values)


    end

    def check_rooms(rooms)
      if !rooms.size.between?(1,5) || rooms.any?(nil) || !rooms.uniq!.nil?
        raise ArgumentError.new("invalid initial rooms")
      end
      return rooms
    end

    def check_if_double_booked(new_rooms)
      @@blocks.each do |block|
        raise ArgumentError.new if self.conflicts_with?(block) ||
          block.get_rooms { |room| new_rooms.include?(room) }
      end
    end

  end
end
