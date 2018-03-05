module Hotel

  class Reservation
      attr_reader :id, :room_number, :check_in_date, :check_out_date

    def initialize(initial_info)
      @id = initial_info[:id]
      @room_number = initial_info[:room_number]
      @check_in_date = initial_info[:check_in_date]
      @check_out_date = initial_info[:check_out_date]
    end

  end
end
