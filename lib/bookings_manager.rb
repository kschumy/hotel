# QUESTION: is it better to check if valid date immediately or wait until making
# reservation?

module Hotel
  # ROOM_RATE = 200.0
  # NUM_OF_ROOMS = 20

  class BookingsManager
      # attr_reader :room, :reservations

    def initialize
      @rooms = [*1..20]
      @reservations = []
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

    def book_a_new_reservation(input_check_in, input_check_out)
      reservation_info = {
        id: @reservations.length + 1,
        room_number: rand(1..20),
        check_in: input_check_in,
        check_out: input_check_out
      }
      @reservations << Hotel::Reservation.new(reservation_info)
      return @reservations.last
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

# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation

# Constraints
# - The hotel has 20 rooms, and they are numbered 1 through 20
# - Every room is identical, and a room always costs $200/night
# - The last day of a reservation is the checkout day, so the guest should not be
#   charged for that night
# - For this wave, any room can be reserved at any time, and you don't need to
#   check whether reservations conflict with each other

# Error Handling
# - Your code should raise an error (StandardError) when an invalid date range
#   is provided

# Hints
# You might want to investigate Ruby's Date gem.
