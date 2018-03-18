require_relative 'reservable'

module Hotel

  RATE = 200.0

  class HotelManager
    # include Reservable

    ROOMS = (1..20).to_a

    def initialize()
      @reservations = rooms
    end

    def get_reservations
      return @reservations.dup
    end

    def get_available_rooms(check_in, check_out)
      reservations_in_range = find_reservations_in_range(check_in: check_in,
        check_out: check_out)
      return get_rooms - reservations_in_range.collect { |res| res.room }
    end

    def get_rooms(block_id = nil)
      return block_id.nil? ? ROOMS.dup : get_block_rooms(block_id)
    end

    def reserve_room(check_in, check_out)
      reserve_room_with_info(check_in, check_out)
    end

    def get_reservations_on_date(date)
      return find_reservations_in_range(check_in: date)
    end

    def get_reservations_in_date_range(check_in, check_out)
      return find_reservations_in_range(check_in: check_in, check_out: check_out)
    end

    def get_cost(reservation_id)

    end

    def reserve_room_in_block(block_id)
       get_block_rooms(block_id).reserve_room
    end

    private


        def get_new_reservation_info(check_in, check_out)
          room_num = get_available_rooms(check_in, check_out).sample
          raise ArgumentError.new("No room available") if room_num.nil?
          return {room: room_num, check_in: check_in, check_out: check_out}
        end

        def find_reservations_in_range(check_in:, check_out: nil, res_list: get_reservations)
          return res_list.select { |res|
            res if !res.is_held? && res.conflicts_with?(check_in: check_in,
              check_out: check_out) }
        end


    def reserve_room_with_info(check_in, check_out)
      res_info = get_new_reservation_info(check_in, check_out)
      res_info.merge!({id: @reservations.size + 1})
      @reservations << Reservation.new(res_info)
      # return reservation_info
    end

     def get_block_rooms(id)
      Hotel::Blocks.get_block(id) or raise ArgumentError("Invalid ID")
     end

    def burn_it_to_the_ground
      exit
    end


  end
end
