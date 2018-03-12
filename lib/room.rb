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
      check_if_valid_range(reservation)
      is_available_for_new_reservation(reservation)
      add_reservation_to_reservations(reservation)
    end

    #
    def reservations
      return @reservations.dup
    end

    #
    def is_available?(date_range)
      check_if_valid_range(date_range)
      return is_available_on_dates?(date_range)
    end

    private

    #
    def is_available_for_new_reservation(new_res)
      if !is_available_on_dates?(new_res)
        raise ArgumentError.new("Not available for #{new_res}.")
      end
    end

    #
    def is_available_on_dates?(date_range)
      return !@reservations.any? { |reservation|
        conflicts_with_dates?(date_range, reservation) }
    end

    # #
    # def has_reservation_or_error(reservation)
    #   if !reservation.respond_to?(:check_in) || !reservation.respond_to?(:check_out)
    #     raise ArgumentError.new("#{reservation} must respond to conflicts_with?")
    #   end
    # end

    #
    def add_reservation_to_reservations(reservation)
      @reservations << reservation
    end

    # #
    # def check_initial_number
    #   if !number.is_a?(Integer) || !number.between?(1, NUM_OF_ROOMS)
    #     raise ArgumentError.new("Invalid room number #{number}")
    #   end
    # end

  end
end
