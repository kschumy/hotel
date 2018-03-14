module DatesRangeModule

  DateRange = Struct.new(:check_in, :check_out)
  # def
  #     @check_in = check_in
  #     @check_out = check_out
  #     check_if_valid_dates(@check_in, @check_out)
  #   end

    def get_duration
      return self.check_out - self.check_in
    end

    #
    def conflicts_with?(date_range_or_check_in:, check_out: nil)
      date_range_or_check_in = DateRange.new(date_range_or_check_in, check_out)
      check_if_valid_range(other)
      return !(other.check_out <= self.check_in || other.check_in >= self.check_out)
    end

    def has_same_date_range?(other)
      check_if_valid_range(other)
      return self == other
    end

    # def check_if_valid_initial_dates
    #   if self.check_out.nil? && self.check_in.is_a?(Date)
    #     self.check_out = @check_in.next_day
    #   else
    #     check_if_valid_dates(@check_in, @check_out)
    #   end
    # end

    # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
    # check_in_date is not at least one day before check_out_date.
    def check_if_valid_dates(start_date, end_date)
      if !start_date.is_a?(Date) || !end_date.is_a?(Date)
        raise ArgumentError.new("Invalid #{start_date} and/or #{end_date}")
      end
      raise ArgumentError.new("Invalid dates range") if start_date >= end_date
    end

    # # Throw ArgumentError if provided date is not a Date.
    # def has_date_or_error(date)
    #   raise ArgumentError.new("Invalid date #{date}.") if !date.is_a?(Date)
    #   # return date
    # end

    # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
    # check_in_date is not at least one day before check_out_date.
    def check_if_valid_range(date_range)
      if !date_range.respond_to?(:check_in) || !date_range.respond_to?(:check_out)
        raise ArgumentError.new("#{date_range} must have check_in and check_out")
      end
      check_if_valid_dates(date_range.check_in, date_range.check_out)
    end


end


# module ReservationDates
#

#
#   # Throw ArgumentError if provided date is not a Date.
#   def has_date_or_error(date)
#     if date.class != Date
#       raise ArgumentError.new("Invalid date #{date}.")
#     end
#     # return date
#   end
#
#   def get_duration(start_date, end_date)
#     check_if_valid_dates(start_date, end_date)
#     return end_date - start_date
#   end
#
#   # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
#   # check_in_date is not at least one day before check_out_date.
#   def check_if_valid_dates(start_date, end_date)
#     has_date_or_error(start_date)
#     has_date_or_error(end_date)
#     raise ArgumentError.new("Invalid dates range.") if end_date - start_date < 1
#   end
#
#   # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
#   # check_in_date is not at least one day before check_out_date.
#   def check_if_valid_range(date_range)
#     if !date_range.respond_to?(:check_in) || !date_range.respond_to?(:check_out)
#       raise ArgumentError.new("#{date_range} must have check_in and check_out")
#     end
#     check_if_valid_dates(date_range.check_in, date_range.check_out)
#   end
#
#   #
#   def conflicts_with?(new_res, curr_res)
#     check_if_valid_range(new_res)
#     check_if_valid_range(curr_res)
#     return !(new_res.check_out <= curr_res.check_in ||
#       new_res.check_in >= curr_res.check_out)
#   end
#
#   def has_same_date_range?(new_res, curr_res)
#     check_if_valid_range(new_res)
#     check_if_valid_range(curr_res)
#     return new_res == curr_res
#   end
#
#   def get_date_range(check_in:, check_out:)
#     has_date_or_error(check_in)
#     check_out.nil? ? check_out = check_in.next_day : has_date_or_error(check_out)
#     return Struct.new(check_in, check_out)
#   end
#
# end
