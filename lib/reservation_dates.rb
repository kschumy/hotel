module ReservationDates

  # DateRange = Struct.new(:check_in, :check_out)

  # Throw ArgumentError if provided date is not a Date.
  def has_valid_date_or_error(date)
    if date.class != Date
      raise ArgumentError.new("Invalid date #{date}.")
    end
    # return date
  end

  def get_reservation_duration(start_date, end_date)
    check_if_valid_dates(start_date, end_date)
    return end_date - start_date
  end

  # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
  # check_in_date is not at least one day before check_out_date.
  def check_if_valid_dates(start_date, end_date)
    has_valid_date_or_error(start_date)
    has_valid_date_or_error(end_date)
    raise ArgumentError.new("Invalid dates range.") if end_date - start_date < 1
  end

  # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
  # check_in_date is not at least one day before check_out_date.
  def check_if_valid_range(date_range)
    if !date_range.respond_to?(:check_in) || !date_range.respond_to?(:check_out)
      raise ArgumentError.new("#{date_range} must have check_in and check_out")
    end
    check_if_valid_dates(date_range.check_in, date_range.check_out)
  end

  #
  def conflicts_with_dates?(new_res, curr_res)
    check_if_valid_range(new_res)
    check_if_valid_range(curr_res)
    return !(new_res.check_out <= curr_res.check_in || new_res.check_in >= curr_res.check_out)
  end

end
