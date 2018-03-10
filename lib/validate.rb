module Validate

  ROOM_RATE = 200.0
  NUM_OF_ROOMS = 20

  # Throw ArgumentError if provided date is not a Date.
  def has_valid_date_or_error(date)
    if date.class != Date
      raise ArgumentError.new("Invalid date #{date}.")
    end
  end

  # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
  # check_in_date is not at least one day before check_out_date.
  def check_if_valid_dates(start_date, end_date)
    has_valid_date_or_error(start_date)
    has_valid_date_or_error(end_date)
    if end_date - start_date < 1
      raise ArgumentError.new("Reservation must be at least one day.")
    end
  end

end
