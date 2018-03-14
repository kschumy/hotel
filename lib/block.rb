# require_relative 'reservation_dates'
# require_relative 'reservable'

module Hotel
  class Block < HotelManager

    extend DatesRangeModule

    # include ReservationDates
    # include Reservable

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

    def get_available_rooms(check_in, check_out)


      if !has_same_dates?(new_res, curr_res)

        raise Argument_Error.new()
      end
    end



    def self.get_available_rooms(block_id)
      return get_block(block_id).get_rooms - get_reservations.collect { |res| res.room }
    end


    def get_rooms
      return @rooms.dup
    end

    # def get_reservations
    #   return @reservations.dup
    # end



    private

    def self.get_block(block_id)
      return @@all_blocks.select { |block| block.id }
    end


  end
end



# def get_available_rooms(check_in, check_out)
#   if conflicts_with?(new_res, curr_res)
#   res_in_range = get_reservations_in_range(check_in: check_in,
#     check_out: check_out)
#   return get_rooms - res_in_range.collect { |res| res.room }
# end
#
# def get_reservations
#   return @reservations.dup
# end
#
# def get_reservations_on_date(date)
#   return get_reservations_in_range(check_in: date)
# end
#
# def reserve_room(check_in, check_out)
#   room_num = get_available_rooms(check_in, check_out).first
#   @reservations << Reservation.new({room: room_num,
#     check_in: check_in, check_out: check_out})
# end
#
#
# private
#
# def get_reservations_in_range(check_in:, check_out:)
#   range = get_date_range(check_in: check_in, check_out: check_out)
#   return get_reservations.select { |res| res if conflicts_with?(res, range) }
# end
