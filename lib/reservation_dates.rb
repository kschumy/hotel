module ReservationDates


  ROOM_RATE = 200.0
  NUM_OF_ROOMS = 20

  DateRange = Struct.new(:check_in, :check_out)

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
    raise ArgumentError.new("Invalid input") if !date_range.is_a?(DateRange)
    has_valid_date_or_error(date_range.check_in)
    has_valid_date_or_error(date_range.check_out)
    raise ArgumentError.new("Invalid dates range.") if end_date - start_date < 1
  end

  #
  def conflicts_with_dates?(start_1, end_1, start_2, end_2)
    check_if_valid_dates(start_1, end_1)
    check_if_valid_dates(start_2, end_2)
    return !(end_1 <= start_2 || start_1 >= end_2)
  end




end
