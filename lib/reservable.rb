# Class that uses this module must
module Reservable

  def get_reservations
    return @reservations.dup
  end

  def get_available_rooms(check_in, check_out)
    reservations_in_range = find_reservations_in_range(check_in: check_in,
      check_out: check_out)
    return get_rooms - reservations_in_range.collect { |res| res.room }
  end

  private

  def get_new_reservation_info(check_in, check_out)
    room_num = get_available_rooms(check_in, check_out).sample
    raise ArgumentError.new("No room available") if room_num.nil?
    return {room: room_num, check_in: check_in, check_out: check_out}
  end

  def find_reservations_in_range(check_in:, check_out: nil, res_list: get_reservations)
    return res_list.select { |res| res if
      res.conflicts_with?(check_in: check_in, check_out: check_out) }
  end


end
