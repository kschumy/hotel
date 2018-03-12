# require_relative 'reservation'

module Hotel

  NUM_OF_ROOMS = 20
  STANDARD_RATE = 200.0

  class HotelManager
    include ReservationDates

    def initialize
      @rooms = build_rooms
      @reservations = Hotel::Reservation.get_all_reservations
    end

    def get_available_rooms(start_date, end_date)
      return @rooms.select do |room|
        room if is_available_on_dates?(@rooms[room], start_date, end_date)
      end
    end

    def get_reservations
      return Hotel::Reservation.get_all_reservations
    end

    def get_reservations_on_date(date)
      one_day_range = get_date_range(date)
      return reservations.select { |res| conflicts_with_dates?(res, one_day_range) }
    end

    def reserve_room(start_date, end_date)
      date_range = get_date_range(start_date, end_date)
      room = get_available_room(date_range)
      room.add_reservation(Reservation.new({room: room.number,
        check_in: date_range.check_in, check_out: date_range.check_out}))
    end

    # Returns a list of room numbers.
    def rooms
      return @rooms.dup
    end

    private

    def get_date_range(start_date, end_date = nil)
      has_date_or_error(start_date)
      end_date.nil? ? end_date = start_date.next_day : has_date_or_error(end_date)
      return DateRange.new(start_date, end_date)
    end

    def get_available_room(date_range)
      return @rooms.find { |room| room if room.is_available?(date_range) }
    end

    def build_rooms
      return Array.new(NUM_OF_ROOMS) { |num| Room.new(num + 1) }
    end

    def burn_it_to_the_ground
      exit
    end

  end
end
