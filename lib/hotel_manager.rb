# require_relative 'reservation'

module Hotel

  NUM_OF_ROOMS = 20
  STANDARD_RATE = 200.0

  class HotelManager
    include ReservationDates

    attr_reader #:rooms

    def initialize
      @rooms = build_rooms
      @reservations = Hotel::Reservation.get_all_reservations
    end

    def get_available_rooms(start_date, end_date)
      return @rooms.select do |room|
        room if is_available_on_dates?(@rooms[room], start_date, end_date)
      end
    end

    # def is_available_on_dates?(check_in_outs, start_date, end_date)
    #   return !check_ins_outs.any? do |check_in_out|
    #     !(end_date <= check_in_out[:check_in] || start_date >= check_in_out[:check_out])
    #   end
    # end

    def get_reservations
      return Hotel::Reservation.get_all_reservations
    end

    def reserve_room(start_date, end_date)
      room = get_available_room(DateRange.new(start_date, end_date))
      room.add_reservation(Reservation.new({room: room.number,
        check_in: start_date, check_out: end_date}))
    end

    # Returns a list of room numbers.
    def rooms
      return @rooms.dup
    end

    # # Throws ArgumentError if input_check_in or input_check_out are not Dates.
    # def reserve_room(input_check_in, input_check_out)
    #   return book_a_new_reservation(input_check_in, input_check_out)
    # end
    #
    # def add_reservation(reservation)
    #   has_reservation_or_error(reservation)
    #   is_available_for_new_reservation(reservation)
    #   add_reservation_to_reservations(reservation)
    # end
    #
    # def is_available?(start_date, end_date)
    #   return is_available_on_dates?(start_date, end_date)
    # end

    private

    # def is_available_on_dates?(room_res_dates, start_date, end_date)
    #   return !room_res_dates.any? do |room_res_date|
    #     !(end_date <= room_res_date[:check_in] || start_date >= room_res_date[:check_out])
    #   end
    # end

    def get_available_room(date_range)
      return @rooms.find { |room| room if room.is_available?(date_range) }
    end
    #
    # def reserve_room(room_num, start_date, end_date)
    #
    # end

    def build_rooms
      return Array.new(NUM_OF_ROOMS) { |num| Room.new(num + 1) }
      # arr.map { |a| 2*a }
      # (1..NUM_OF_ROOMS).each { |num| @rooms.push() }
    end

    def burn_it_to_the_ground
      exit
    end

  end
end
