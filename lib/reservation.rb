require_relative 'reservation_dates'

module Hotel
  class Reservation

    include DatesRangeModule

    attr_reader :id, :room, :check_in, :check_out, :cost

    def initialize(res_info)
      @check_in = res_info[:check_in]
      @check_out= res_info[:check_out]
      @room = res_info[:room]
      @cost = get_cost(res_info.fetch(:rate, 200.0))
    end

    private

    # Returns the cost, rounded to two decimal places.
    def get_cost(rate)
      raise ArgumentError.new("Invalid rate") if !rate.is_a?(Float) || rate < 0.0
      return (get_duration * rate).round(2)
    end

  end
end
