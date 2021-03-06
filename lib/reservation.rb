require_relative 'reservation_dates'

module Hotel
  class Reservation

    include DatesRangeModule

    attr_reader :id, :room, :check_in, :check_out, :cost

    def initialize(res_info)
      @id = res_info[:id]
      @check_in , @check_out = check_if_valid_dates(res_info[:check_in],
        res_info[:check_out])
      # @check_out = res_info[:check_out]
      @room = res_info[:room]
      @cost = get_cost(res_info.fetch(:rate, RATE))
    end

    def is_held?
      return @id.nil?
    end

    def assign_reservation(new_id)
      if !is_held?
        raise ArgumentError.new("Cannot assign already assigned reservation")
      end
      @id = new_id
    end

    private

    # Returns the cost, rounded to two decimal places.
    def get_cost(rate)
      raise ArgumentError.new("Invalid rate") if !rate.is_a?(Float) || rate < 0.0
      return (get_duration * rate).round(2)
    end

  end
end
