# require_relative 'reservation'

module Hotel

  NUM_OF_ROOMS = 20
  # ROOMS = (1..NUM_OF_ROOMS).to_a
  RATE = 200.0

  class HotelManager
    # include ReservationDates
    # include Reservable

    def initialize()
      @reservations = []
      # @blocks = []
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
      add_reservation(room: room_num, check_in: check_in, check_out: check_out)
      # @reservations << Struct.new(room: room_num, check_in: check_in,
        # check_out: check_out)
      # @reservations << Reservation.new({room: room_num,
      #   check_in: check_in, check_out: check_out})
    end

    def get_rooms
      return (1..NUM_OF_ROOMS).to_a#.dup
    end

    private

    def add_reservation(room:, check_in:, check_out:, cost: RATE)#(room_num, check_in, check_out)
      @reservations << Reservation.new({room: room, check_in: check_in, check_out: check_out})#Struct.new(room, check_in, check_out, (check_out - check_in) * cost))#set_reservation_info(room: room, check_in, check_out)
    end
    #   @reservations.push(Struct.new(room: room, check_in: check_in, check_out:
    #     check_out, cost: (check_out - check_in) * room_rate))#set_reservation_info(room: room, check_in, check_out)
    # end

    def get_reservations_in_range(check_in:, check_out:, res_list: get_reservations)
      # range = Struct.new(check_in: check_in, check_out: check_out)
      return get_reservations.select { |res| res if res.conflicts_with?(check_in: check_in, check_out: check_out) }
    end


    # def set_reservation_info(room:, check_in:, check_out:, room_rate: RATE)
    #   # ResInfo = Struct.new(:room, :check_in, :check_out, :cost)
    #   return  ResInfo.new(room: room, check_in: check_in,
    #       check_out: check_out, cost: date_range * RATE)
    # end

    # def get_date_range(check_in:, check_out:)
    #   has_date_or_error(check_in)
    #   check_out.nil? ? check_out = check_in.next_day : has_date_or_error(check_out)
    #   return Struct.new(check_in, check_out)
    # end

    def burn_it_to_the_ground
      exit
    end


  end
end
