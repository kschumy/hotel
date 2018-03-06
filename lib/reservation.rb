# QUESTION: when should I check for valid?

module Hotel

  class Reservation
      attr_reader :id, :room_number, :check_in, :check_out

    def initialize(initial_info)
      @id = initial_info[:id]
      @room_number = initial_info[:room_number]
      @check_in = initial_info[:check_in]
      @check_out = initial_info[:check_out]
      check_if_valid_id
      check_if_valid_dates
    end

    # Returns the cost, rounded to two decimal places.
    def get_cost
      return (length_of_reservation * ROOM_RATE).round(2)
    end

    private

    # Returns the how long the reservation is in days.
    def length_of_reservation
      return @check_out - @check_in
    end

    # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
    # check_in_date is not at least one day before check_out_date.
    def check_if_valid_dates
      Hotel.has_valid_date_or_error(@check_in)
      Hotel.has_valid_date_or_error(@check_out)
      if length_of_reservation < 1
        raise ArgumentError.new("Reservation must be at least one day.")
      end
    end

    # Returns the how long the reservation is in days.
    def check_if_valid_id
      if @id.class != Integer || @id < 1
        raise ArgumentError.new("Invalid Id #{@id}. Must be int > 0")
      end
    end

  end
end
