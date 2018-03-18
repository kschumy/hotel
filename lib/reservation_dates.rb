module DatesRangeModule

  DateRange = Struct.new(:check_in, :check_out)

  def get_duration
    return self.check_out - self.check_in
  end

  #
  def conflicts_with?(check_in:, check_out: nil)
    other_dates = DateRange.new(check_in, check_out)
    check_if_valid_range(other_dates)
    return !(other_dates.check_out <= self.check_in || other_dates.check_in >= self.check_out)
  end

  def has_same_date_range?(other)
    check_if_valid_range(other)
    return self.check_in == other.check_in && self.check_out == other.check_out
  end

  # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
  # check_in_date is not at least one day before check_out_date.
  def check_if_valid_dates(start_date, end_date)
    if !start_date.is_a?(Date) || !end_date.is_a?(Date)
      raise ArgumentError.new("Invalid #{start_date} and/or #{end_date}")
    end
    raise ArgumentError.new("Invalid dates range") if start_date >= end_date
  end

  # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
  # check_in_date is not at least one day before check_out_date.
  def check_if_valid_range(date_range)
    if !date_range.respond_to?(:check_in) || !date_range.respond_to?(:check_out)
      raise ArgumentError.new("#{date_range} must have check_in and check_out")
    end
    check_if_valid_dates(date_range.check_in, date_range.check_out)
  end

end
