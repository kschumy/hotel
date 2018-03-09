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
      Hotel.check_if_valid_dates(@check_in, @check_out)
    end

    # Returns the cost, rounded to two decimal places.
    def get_cost
      return (length_of_reservation(@check_in, @check_out) * ROOM_RATE).round(2)
    end

    def conflicts_with?(start_date, end_date)
      Hotel.check_if_valid_dates(start_date, end_date)
      return !(end_date <= @check_in || start_date >= @check_out)
    end

    private

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
