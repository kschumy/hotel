
module HotelSystem
  # # ROOM_RATE = 200.0
  # NUM_OF_ROOMS = 20


  # - About
  #   - 20 rooms
  #   - numbered 1 through 20
  #   - identical
  #   - costs $200/night
  # - I can reserve a room for a given date range
  # - I can view a list of rooms that are not reserved for a given date range
  # - I can reserve an available room for a given date range
  # - I can create a block of rooms
  #   - To create a block you need a date range, collection of rooms and a
  #   discounted room rate
  #   - collection of rooms should only include rooms that are available for
  #   the given date range
  #   - If a room is set aside in a block, it is not available for reservation
  #   by the general public, nor can it be included in another block
  #   - I can check whether a given block has any rooms available
  #   - I can reserve a room from within a block of rooms
  #   - A block can contain a maximum of 5 rooms
  #   - I can reserve a room from within a block of rooms
  #   - When a room is reserved from a block of rooms, the reservation dates
  #   will always match the date range of the block
  #   - All of the availability checking logic from Wave 2 should now respect
  #   room blocks as well as individual reservations

  class RoomsManager
    ROOMS = [1..20]

    def initialize
      @blocks = {}
    end

    def get_available_rooms(start_date, end_date)
      return @rooms.select do |room|
        room if is_available_on_dates?(@rooms[room], start_date, end_date)
      end
    end

    def is_available_on_dates?(check_in_outs, start_date, end_date)
      return !check_ins_outs.any? do |check_in_out|
        !(end_date <= check_in_out[:check_in] || start_date >= check_in_out[:check_out])
      end
    end

    def book_room
      room = get_available_room(start_date, end_date)
      room
    end

    # Returns a list of room numbers.
    def rooms
      return ROOMS.dup
    end

    # Throws ArgumentError if input_check_in or input_check_out are not Dates.
    def reserve_room(input_check_in, input_check_out)
      return book_a_new_reservation(input_check_in, input_check_out)
    end

    def add_reservation(reservation)
      has_reservation_or_error(reservation)
      is_available_for_new_reservation(reservation)
      add_reservation_to_reservations(reservation)
    end

    def is_available?(start_date, end_date)
      return is_available_on_dates?(start_date, end_date)
    end

    private

    def get_available_room(start_date, end_date)
      return @rooms.find do |room_num, dates|
        room if is_available_on_dates?(d, start_date, end_date)
      end
    end

  end
end
