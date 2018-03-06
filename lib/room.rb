# QUESTION: circular logic about checking if reservation.room is 'this'?

module Hotel
  # # ROOM_RATE = 200.0
  # NUM_OF_ROOMS = 20

  class Room
      attr_reader :number

    def initialize(initial_number)
      @number = initial_number
      @reservations = []
      check_initial_number
    end

    def add_reservation(reservation)
      has_reservation_or_error(reservation)
      add_reservation_to_reservations(reservation)
    end

    def reservations
      return @reservations.dup
    end

    def is_available?(start_date, end_date)
      return !@reservations.any?{ |res| res.conflicts_with?(start_date, end_date) }
    end

    private

    def check_initial_number
      if @number.class != Integer || !@number.between?(1, NUM_OF_ROOMS)
        raise ArgumentError.new("Invalid room number #{@number}")
      end
    end

    def add_reservation_to_reservations(reservation)
      @reservations << reservation
    end

    def has_reservation_or_error(reservation)
      if reservation.class != Reservation
        raise ArgumentError.new("#{reservation} is not a Reservation.")
      end
    end

  end
end
