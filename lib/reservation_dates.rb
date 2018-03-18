module DatesRangeModule

  # DateRange = Struct.new(:check_in, :check_out)

  def get_duration
    return self.check_out - self.check_in
  end

  # Throws StandardError if other does not respond do check_in and check_out, or
  # if the values from those calls do not produce a valid date range.
  def conflicts_with_other?(other)
     return conflicts_with?(check_in: other.check_in, check_out: other.check_out)
  end

  def conflicts_with?(check_in:, check_out: nil)
    check_in, check_out = check_dates(check_in, check_out)
    return !(check_out <= self.check_in || check_in >= self.check_out)
  end

  def has_same_range?(other)
    return has_same_dates?(check_in: other.check_in, check_out: other.check_out)
  end

  def has_same_dates?(check_in:, check_out: nil)
    # check_if_valid_range(other)
    return self.check_in == other.check_in && self.check_out == other.check_out
  end

  private

  # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
  # check_in_date is not at least one day before check_out_date.
  def check_if_valid_dates(other_check_in, other_check_out)
    if !other_check_in.is_a?(Date) || !other_check_out.is_a?(Date)
      raise ArgumentError.new("Invalid other_check_in and/or other_check_out")
    end
    raise ArgumentError.new("Invalid range") if other_check_in >= other_check_out
    return other_check_in, other_check_out
  end


  def check_dates(other_check_in, other_check_out)
     return other_check_in, other_check_in.next_day if other_check_out.nil? # throws error if not date
     return check_if_valid_dates(other_check_in, other_check_out)
  end

  # # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
  # # check_in_date is not at least one day before check_out_date.
  # def check_if_valid_range(date_range)
  #   if !date_range.respond_to?(:check_in) || !date_range.respond_to?(:check_out)
  #     raise ArgumentError.new("#{date_range} must have check_in and check_out")
  #   end
  #   check_if_valid_dates(date_range.check_in, date_range.check_out)
  # end

end
