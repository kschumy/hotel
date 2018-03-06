module Hotel
  # # ROOM_RATE = 200.0
  # NUM_OF_ROOMS = 20

  class Room
      attr_reader :number

    def initialize(initial_number)
      @number = initial_number
      @reservations = []
      check_initial_number
    end

    private

    def check_initial_number
      if @number.class != Integer || !@number.between?(1, NUM_OF_ROOMS)
        raise ArgumentError.new("Invalid room number #{@number}")
      end
    end

    def add_reservation

    end

  end
end
