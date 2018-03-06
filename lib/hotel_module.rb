module Hotel
# private_class_method :length_of_reservation

  ROOM_RATE = 200.0
  NUM_OF_ROOMS = 20

  # # Throw ArgumentError if provided date is not a Date.
  # def self.has_valid_date_or_error(date)
  #   if date.class != Date
  #     raise ArgumentError.new("Invalid date #{date}.")
  #   end
  # end

  # Throw ArgumentError is check_in_date or check_out_date are not Dates or if
  # check_in_date is not at least one day before check_out_date.
  def self.check_if_valid_dates(start_date, end_date)
    has_valid_date_or_error(start_date)
    has_valid_date_or_error(end_date)
    if length_of_reservation(start_date, end_date) < 1
      raise ArgumentError.new("Reservation must be at least one day.")
    end
  end

# TODO: is this bad?
  def self.get_duration(start_date, end_date)
    check_if_valid_dates(start_date, end_date)
    return length_of_reservation(start_date, end_date)
  end


  # private

  # Returns the how long the reservation is in days.
  def self.length_of_reservation(start_date, end_date)
    return end_date - start_date
  end

  # Throw ArgumentError if provided date is not a Date.
  def self.has_valid_date_or_error(date)
    if date.class != Date
      raise ArgumentError.new("Invalid date #{date}.")
    end
  end

  private_class_method :length_of_reservation


end
