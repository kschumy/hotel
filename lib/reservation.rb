require_relative 'reservation_dates'

module Hotel

  class Reservation
    include ReservationDates

    RATE = 200.0

    @@all_reservations = []

    attr_reader :id, :room, :check_in, :check_out#, :cost

    def initialize(initial_info)
      @id = @@all_reservations.size + 1
      @room = initial_info[:room]
      @check_in = initial_info[:check_in]
      @check_out = initial_info[:check_out]
      check_if_valid_dates(@check_in, @check_out)
      # @cost = get_cost(initial_info[:rate])
      @@all_reservations << self
    end

    # Returns the cost, rounded to two decimal places.
    def get_cost
      # check_if_valid_dates(@check_in, @check_out)
      # raise ArgumentError.new("Invalid rate") if !rate.is_a?(Float) || rate < 0.0
      return (length_of_reservation(@check_in, @check_out) * RATE).round(2)
    end

    # def conflicts_with?(start_date, end_date)
    #   check_if_valid_dates(start_date, end_date)
    #   return !(end_date <= @check_in || start_date >= @check_out)
    # end

    def self.get_all_reservations
      return @@all_reservations.dup
    end

    private

    # Returns the how long the reservation is in days.
    def length_of_reservation(start_date, end_date)
      return end_date - start_date
    end

  end
end
