module Reservable

  def get_reservations
    return @reservations.dup
  end

  def get_available_rooms(check_in, check_out)
    res_in_range = get_reservations_in_range(check_in: check_in,
      check_out: check_out)
    return get_rooms - res_in_range.collect { |res| res.room }
  end

  def get_new_reservation_info(check_in, check_out)
    room_num = get_available_rooms(check_in, check_out).first
    return {room: room_num, check_in: check_in, check_out: check_out}
  end

  private

  def get_reservations_in_range(check_in:, check_out:, res_list: get_reservations)
    return get_reservations.select { |res| res if
      res.conflicts_with?(check_in: check_in, check_out: check_out) }
  end


end
