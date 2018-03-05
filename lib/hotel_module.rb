module Hotel

  # Throw ArgumentError if provided date is not a Date.
  def self.has_valid_date_or_error(date)
    if date.class != Date
      raise ArgumentError.new("Invalid date #{date}.")
    end
  end

end
