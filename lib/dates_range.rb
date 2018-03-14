# module Hotel
#
#   class DatesRange
#
#     attr_reader :check_in, :check_out
#
#     def initialize(check_in:, check_out: nil)
#       @check_in = check_in
#       @check_out = check_out
#       check_if_valid_dates(@check_in, @check_out)
#     end
#
#     def get_duration
#       return @check_out - @check_in
#     end
#
#     #
#     def conflicts_with?(other)
#       check_if_valid_range(other)
#       return !(other.check_out <= @check_in || other.check_in >= @check_out)
#     end
#
#     def has_same_date_range?(other)
#       check_if_valid_range(other)
#       return self == other
#     end
#
#     private
#
#     def check_if_valid_initial_dates
#       if @check_out.nil? && @check_in.is_a?(Date)
#         @check_out = @check_in.next_day
#       else
#         check_if_valid_dates(@check_in, @check_out)
#       end
#     end
#
#     # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
#     # check_in_date is not at least one day before check_out_date.
#     def check_if_valid_dates(start_date, end_date)
#       if !start_date.is_a?(Date) || !end_date.is_a?(Date)
#         raise ArgumentError.new("Invalid #{start_date} and/or #{end_date}")
#       end
#       raise ArgumentError.new("Invalid dates range") if start_date >= end_date
#     end
#
#     # # Throw ArgumentError if provided date is not a Date.
#     # def has_date_or_error(date)
#     #   raise ArgumentError.new("Invalid date #{date}.") if !date.is_a?(Date)
#     #   # return date
#     # end
#
#     # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
#     # check_in_date is not at least one day before check_out_date.
#     def check_if_valid_range(date_range)
#       if !date_range.respond_to?(:check_in) || !date_range.respond_to?(:check_out)
#         raise ArgumentError.new("#{date_range} must have check_in and check_out")
#       end
#       check_if_valid_dates(date_range.check_in, date_range.check_out)
#     end
#
#   end
# end
