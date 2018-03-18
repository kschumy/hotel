require_relative 'reservable'

module Hotel

  NUM_OF_ROOMS = 20
  # ROOMS = (1..NUM_OF_ROOMS).to_a
  RATE = 200.0

  class HotelManager

    include Reservable

    def initialize()
      @reservations = []
    end

    def get_reservations_on_date(date)
      return get_reservations_in_range(check_in: date)
    end

    def reserve_room(check_in, check_out)
      reservation_info = get_new_reservation_info(check_in, check_out)
      new_reservation = Reservation.new(reservation_info)
      @reservations << new_reservation
    end

    def get_rooms(block_id = nil)
      return block_id.nil? ? (1..NUM_OF_ROOMS).to_a : get_block_rooms(block_id)
    end

    private

     def get_block_rooms(id)
      Hotel::Blocks.get_block(id) or raise ArgumentError("Invalid ID")
     end


    def burn_it_to_the_ground
      exit
    end


  end
end
