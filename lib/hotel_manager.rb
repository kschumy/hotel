
module Hotel

  NUM_OF_ROOMS = 20

  class HotelManager
    include Validate

    attr_reader :rooms

    def initialize
      @rooms = []
      # @blocks = {}
      build_rooms
    end

    # def get_available_rooms(start_date, end_date)
    #   return @rooms.select do |room|
    #     room if is_available_on_dates?(@rooms[room], start_date, end_date)
    #   end
    # end
    #
    # def is_available_on_dates?(check_in_outs, start_date, end_date)
    #   return !check_ins_outs.any? do |check_in_out|
    #     !(end_date <= check_in_out[:check_in] || start_date >= check_in_out[:check_out])
    #   end
    # end
    #
    def book_room
      room = get_available_room(start_date, end_date)
      room
    end

    # Returns a list of room numbers.
    def rooms
      return @rooms.dup
    end

    # # Throws ArgumentError if input_check_in or input_check_out are not Dates.
    # def reserve_room(input_check_in, input_check_out)
    #   return book_a_new_reservation(input_check_in, input_check_out)
    # end
    #
    # def add_reservation(reservation)
    #   has_reservation_or_error(reservation)
    #   is_available_for_new_reservation(reservation)
    #   add_reservation_to_reservations(reservation)
    # end
    #
    # def is_available?(start_date, end_date)
    #   return is_available_on_dates?(start_date, end_date)
    # end

    private

    def build_rooms
      @rooms = (1..NUM_OF_ROOMS).map { |num| num }
    end

    # def get_available_room(start_date, end_date)
    #   return @rooms.find do |room_num, dates|
    #     room if is_available_on_dates?(d, start_date, end_date)
    #   end
    # end

  end
end
