# require_relative 'validate'

module Hotel
  class Room
    include ReservationDates
      attr_reader :number, :rate

    def initialize(initial_number, initial_rate = 200.0)
      @number = initial_number
      @rate = initial_rate
      @reservations = []
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
      check_if_valid_dates(start_date, end_date)
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
        raise ArgumentError.new("#{reservation} must respond to conflicts_with?")
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
