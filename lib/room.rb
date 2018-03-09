# require_relative 'validate'
# QUESTION: circular logic about checking if reservation.room is 'this'?

module Hotel
  class Room
    # include Validate
      attr_reader :number

    def initialize(initial_number)
      @number = initial_number
      @reservations = []
      check_initial_number
    end

    #
    def add_reservation(reservation)
      has_reservation_or_error(reservation)
      is_available_for_new_reservation(reservation)
      add_reservation_to_reservations(reservation)
    end

    #
    def reservations
      return @reservations.dup
    end

    #
    def is_available?(start_date, end_date)
      Hotel.check_if_valid_dates(start_date, end_date)
      return is_available_on_dates?(start_date, end_date)
    end

    private

    #
    def is_available_for_new_reservation(new_res)
      if !is_available_on_dates?(new_res.check_in, new_res.check_out)
        raise ArgumentError.new("Not available for #{new_res}.")
      end
    end

    #
    def is_available_on_dates?(start_date, end_date)
      return !@reservations.any?{ |res| res.conflicts_with?(start_date, end_date) }
    end

    #
    def has_reservation_or_error(reservation)
      if !reservation.respond_to?(:conflicts_with?)
      # if reservation.class != Reservation
        raise ArgumentError.new("#{reservation} is not a Reservation.")
      end
    end

    #
    def add_reservation_to_reservations(reservation)
      @reservations << reservation
    end

    #
    def check_initial_number
      if !number.is_a?(Integer) || !number.between?(1, NUM_OF_ROOMS)
        raise ArgumentError.new("Invalid room number #{number}")
      end
    end

  end
end
