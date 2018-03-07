# QUESTION: is it better to check if valid date immediately or wait until making
# reservation?

module Hotel
  class BookingsManager
      # attr_reader :room, :reservations

    def initialize
      @rooms = []
      @reservations = []
      load_rooms
    end

    # Throws ArgumentError if input_check_in or input_check_out are not Dates.
    def reserve_room(input_check_in, input_check_out)
      return book_a_new_reservation(input_check_in, input_check_out)
    end

    #
    def get_reservations_on_date(date)
      Hotel.has_valid_date_or_error(date)
      return find_reservations_on_date(date)
    end


    def get_available_rooms(start_date, end_date)
      return @rooms.select { |room| room if room.is_available?(start_date, end_date)}
    end

    #
    def get_reservation_cost(reservation_id)
      has_valid_reservation_id_or_error(reservation_id)
      return find_reservation_by_id(reservation_id).get_cost
    end

    # Returns a list of room numbers.
    def rooms
      return @rooms.dup
    end

    # Returns a list of reservations.
    def reservations
      return @reservations.dup
    end

    private


    def load_rooms
      @rooms = []
      (1..NUM_OF_ROOMS).each { |num| @rooms << Hotel::Room.new(num) }
    end

    def book_a_new_reservation(input_check_in, input_check_out)
      reservation_info = {
        id: @reservations.length + 1,
        room_number: find_available_room(input_check_in, input_check_out),
        check_in: input_check_in,
        check_out: input_check_out
      }
      new_reservation = Hotel::Reservation.new(reservation_info)
      add_reservation_to_room(new_reservation)
      @reservations << new_reservation
      return new_reservation
    end

    def add_reservation_to_room(new_reservation)
      @rooms[new_reservation.room_number - 1].add_reservation(new_reservation)
    end

    # Provided date must be a valid Date.
    # Returns the reservations that overlap with the provided date. If no
    # reservations overlap with date, returns an empty ArrayList. All
    # reservations with check-out dates on provided date are excluded.
    def find_reservations_on_date(date)
      return @reservations.select { |reservation| reservation if
        is_date_between_dates?(date, reservation) }
    end

    # Provided id must be a valid id for reservations.
    # Returns the reservation with the provided id.
    def find_reservation_by_id(id)
      return @reservations[id - 1]
    end

    def find_available_room(start_date, end_date)
      return @rooms.find { |room| room if room.is_available?(start_date, end_date)}.number
    end

    # Provided date must be a valid Date.
    # Return 'true' if date is between check-in (inclusive) and check-out
    # (exclusive) of the provided reservation.
    def is_date_between_dates?(date, reservation)
      return date >= reservation.check_in && date < reservation.check_out
    end

    #
    def has_valid_reservation_id_or_error(id)
      if id.class != Integer || !id.between?(1, @reservations.length)
        raise ArgumentError.new("Invalid id #{id}")
      end
    end

  end
end

# Wave Two: Room Availability
# User Stories
# As an administrator, I can view a list of rooms that are not reserved for a
# given date range
# As an administrator, I can reserve an available room for a given date range

# Constraints
# A reservation is allowed start on the same day that another reservation for
# the same room ends

# Error Handling
# Your code should raise an exception when asked to reserve a room that is not
# available
