require_relative 'reservation_dates'
require_relative 'reservable'


module Hotel
  class Reservation

    include ReservationDates
    include Reservable

    # @@all_reservations = []

    attr_reader :id, :room, :check_in, :check_out, :cost #:id,

    def initialize(initial_info)
      # @id = @@all_reservations.size + 1
      @room = initial_info[:room]
      @check_in = initial_info[:check_in]
      @check_out = initial_info[:check_out]
      @cost = get_cost(initial_info.fetch(:rate, 200.0))
      # @@all_reservations << self
    end


    # def self.get_all_reservations
    #   return @@all_reservations.dup
    # end

    # def self.get_reservations_on_range
    #   return get_all_reservations.select { |res| res if conflicts_with_dates?(res, range) }
    # end

    private

    # Returns the cost, rounded to two decimal places.
    def get_cost(rate)
      raise ArgumentError.new("Invalid rate") if !rate.is_a?(Float) || rate < 0.0
      length_of_reservation = get_reservation_duration(@check_in, @check_out)
      return (length_of_reservation * rate).round(2)
    end

  end
end
