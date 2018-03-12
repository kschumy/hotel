require_relative 'reservation_dates'

module Hotel
  class Reservation

    include ReservationDates

    @@all_reservations = []

    attr_reader :id, :room, :check_in, :check_out, :cost

    def initialize(initial_info)
      @id = @@all_reservations.size + 1
      @room = initial_info[:room]
      @check_in = initial_info[:check_in]
      @check_out = initial_info[:check_out]
      @cost = get_cost(initial_info.fetch(:rate, 200.0))
      @@all_reservations << self
    end


    def self.get_all_reservations
      return @@all_reservations.dup
    end

    private

    # Returns the cost, rounded to two decimal places.
    def get_cost(rate)
      raise ArgumentError.new("Invalid rate") if !rate.is_a?(Float) || rate < 0.0
      length_of_reservation = get_reservation_duration(@check_in, @check_out)
      puts length_of_reservation
      puts rate
      return (length_of_reservation * rate).round(2)
    end

    # def check_initial_rate(rate)
    #   room_rate =
    #   case rate
    #   when :nil
    #     STANDARD_RATE
    #   when :block
    #     STANDARD_RATE * 0.8
    #   else
    #     raise ArgumentError.new("Invalid rate") if !rate.is_a?(Float) || rate < 0.0
    #     rate
    #   end
    #   return room_rate
    # end


  end
end
