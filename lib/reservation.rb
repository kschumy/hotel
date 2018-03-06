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

    def conflicts_with?(start_date, end_date)
      check_if_valid_dates(start_date, end_date)
      return !(end_date < @check_in || start_date >= @check_out)
    end

    private

    # Returns the how long the reservation is in days.
    def length_of_reservation(start_date = @check_in, end_date = @check_out)
      return end_date - start_date
    end

    # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
    # check_in_date is not at least one day before check_out_date.
    def check_if_valid_dates(start_date = @check_in, end_date = @check_out)
      Hotel.has_valid_date_or_error(start_date)
      Hotel.has_valid_date_or_error(end_date)
      if length_of_reservation(start_date, end_date) < 1
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

# conflict = end_date > @check_in && start_date < @check_out
# conflict = false
# puts "#{conflict}"
# curr_date = start_date
# while !conflict && curr_date < end_date
#   print "#{curr_date}: "
#   puts "#{conflict}"
#   conflict = Hotel.is_between_dates?(curr_date, @check_in, @check_out)
#   # conflict = curr_date.between?(@check_in, @check_out.prev_day)
#   curr_date = curr_date.succ
# end
# return conflict
# # return if end_date < @check_in || start_date >= @check_out
# # conflict = end_date > @check_in && start_date < @check_out
# conflict = false
# puts "#{conflict}"
# curr_date = start_date
# while !conflict && curr_date < end_date
#   print "#{curr_date}: "
#   puts "#{conflict}"
#   conflict = Hotel.is_between_dates?(curr_date, @check_in, @check_out)
#   # conflict = curr_date.between?(@check_in, @check_out.prev_day)
#   curr_date = curr_date.succ
# end
# return conflict
