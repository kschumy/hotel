# require_relative 'reservation'

module Hotel

  NUM_OF_ROOMS = 20
  ROOMS = (1..NUM_OF_ROOMS).map { |num| num }
  RATE = 200.0

  class HotelManager
    include ReservationDates
    include Reservable

    def initialize
      @reservations = []
      @blocks = []
    end

    def get_available_rooms(check_in, check_out)
      res_in_range = get_reservations_in_range(check_in: check_in,
        check_out: check_out)
      return get_rooms - res_in_range.collect { |res| res.room }
    end

    def get_reservations
      return @reservations.dup
    end

    def get_reservations_on_date(date)
      return get_reservations_in_range(check_in: date)
    end

    def reserve_room(check_in, check_out)
      room_num = get_available_rooms(check_in, check_out).first
      @reservations << Reservation.new({room: room_num,
        check_in: check_in, check_out: check_out})
    end

    def reserve_room(check_in, check_out)
      @reservations << reserve_a_room(check_in, check_out)
    end

    def get_rooms
      return ROOMS.dup
    end

    private

    def get_reservations_in_range(check_in:, check_out:)
      range = get_date_range(check_in: check_in, check_out: check_out)
      puts range.inspect
      return get_reservations.select { |res| res if conflicts_with_dates?(res, range) }
    end

    def get_date_range(check_in:, check_out:)
      has_date_or_error(check_in)
      check_out.nil? ? check_out = check_in.next_day : has_date_or_error(check_out)
      return DateRange.new(check_in, check_out)
    end

    # def burn_it_to_the_ground
    #   exit
    # end


  end
end
