require_relative 'validate'

module Hotel

  class Reservation
    # @@all_resevations = []

    include Validate

    attr_reader :room, :check_in, :check_out

    def initialize(initial_info)
      @room = initial_info[:room]
      @check_in = initial_info[:check_in]
      @check_out = initial_info[:check_out]
      @cost = get_cost(initial_info[:rate])
      check_if_valid_id
      check_if_valid_dates(@check_in, @check_out)
    end

    def conflicts_with?(start_date, end_date)
      check_if_valid_dates(start_date, end_date)
      return !(end_date <= @check_in || start_date >= @check_out)
    end

    private

    # Returns the cost, rounded to two decimal places.
    def get_cost(rate)
      !rate.is_a(Float) || rate < 0.0 if raise ArgumentError.new("Invalid rate")
      return (length_of_reservation(@check_in, @check_out) * ROOM_RATE).round(2)
    end

    # Returns the how long the reservation is in days.
    def length_of_reservation(start_date = @check_in, end_date = @check_out)
      return end_date - start_date
    end

    # Returns the how long the reservation is in days.
    def check_if_valid_id
      if @id.class != Integer || @id < 1
        raise ArgumentError.new("Invalid Id #{@id}. Must be int > 0")
      end
    end

  end
end
