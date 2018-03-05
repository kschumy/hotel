# require_relative 'driver'
# require_relative 'passenger'
# require_relative 'trip'

# QUESTION: is it better to check if valid date immediately or wait until making
# reservation?


module Hotel
  # ROOM_RATE = 200.0
  NUM_OF_ROOMS = 20

  class BookingsManager
      attr_reader :rooms

    def initialize
      @rooms = [*1..20]
    end

    def reserve_room(input_check_in_date, input_check_out_date)
      reservation_info = {
        id: rand(1..99),
        room_number: rand(1..20),
        check_in_date: input_check_in_date,
        check_out_date: input_check_out_date
      }
      new_reservation = Hotel::Reservation.new(reservation_info)
      return new_reservation
    end

    private

  end
end

# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation

# Constraints
# - The hotel has 20 rooms, and they are numbered 1 through 20
# - Every room is identical, and a room always costs $200/night
# - The last day of a reservation is the checkout day, so the guest should not be
#   charged for that night
# - For this wave, any room can be reserved at any time, and you don't need to
#   check whether reservations conflict with each other

# Error Handling
# - Your code should raise an error (StandardError) when an invalid date range
#   is provided

# Hints
# You might want to investigate Ruby's Date gem.
