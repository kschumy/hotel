# require_relative 'spec_helper'
#
# describe 'BookingsManager class' do
#
#
#   describe 'Initializer' do
#     before do
#       @manager = Hotel::BookingsManager.new
#     end
#
#     it 'is an instance of BookingsManager' do
#       @manager.must_be_instance_of Hotel::BookingsManager
#     end
#
#     it 'creates a list of rooms' do
#       @manager.must_respond_to :rooms
#       @manager.rooms.must_be_kind_of Array
#       (@manager.rooms.all? { |room| room.class == Hotel::Room }).must_equal true
#     end
#
#     it 'assigns room numbers in order' do
#       @manager.rooms[0].number.must_equal 1
#       @manager.rooms[10].number.must_equal 11
#       @manager.rooms[19].number.must_equal 20
#     end
#
#     it 'does not return the original list of rooms' do
#       @manager.rooms.pop
#       @manager.rooms.length.must_equal 20
#     end
#
#     it 'creates a empty list for reservations' do
#       @manager.must_respond_to :reservations
#       @manager.reservations.must_be_kind_of Array
#       @manager.reservations.must_equal []
#     end
#
#     it 'does not return the original list of reservations' do
#       new_room = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,5))
#
#       @manager.reservations.pop
#       @manager.reservations.must_equal [new_room]
#     end
#   end # end of 'Initializer'
#
#   describe 'Reserve Room' do
#     before do
#       @manager = Hotel::BookingsManager.new
#       @initial_check_in = Date.new(2018,2,3)
#       @initial_check_out = Date.new(2018,2,5)
#     end
#
#     it 'is an returns a new Reservation' do
#       reservation = @manager.reserve_room(@initial_check_in, @initial_check_out)
#       reservation.must_be_instance_of Hotel::Reservation
#       reservation.check_in.must_equal @initial_check_in
#       reservation.check_out.must_equal @initial_check_out
#     end
#
#     it 'adds the new reservation to the reservations list' do
#       num_of_reservations_before = @manager.reservations.length
#       reservation = @manager.reserve_room(@initial_check_in, @initial_check_out)
#       @manager.reservations.last.must_equal reservation
#       @manager.reservations.length.must_equal (num_of_reservations_before + 1)
#     end
#
#     it 'sets the reservation numbers by incrementing by one' do
#       reservation = @manager.reserve_room(@initial_check_in, @initial_check_out)
#       reservation.id.must_equal 1
#       reservation2 = @manager.reserve_room(@initial_check_in, @initial_check_out)
#       reservation2.id.must_equal 2
#     end
#   end # end of 'Reserve Room'
#
#   describe 'Get Reservations On Date' do
#     before do
#       @manager = Hotel::BookingsManager.new
#     end
#     it 'returns an empty list if no reservations on date' do
#       @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
#       @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4)) # before
#       @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
#     end
#
#     it 'returns an list of reservations on date' do
#       res1 = @manager.reserve_room(Date.new(2018,2,5), Date.new(2018,2,8))
#       res2 = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,6))
#       res_on_date = @manager.get_reservations_on_date(Date.new(2018,2,5))
#
#       res_on_date.must_equal [res1, res2]
#     end
#
#     it 'only includes reservations that overlap with date' do
#       res1 = @manager.reserve_room(Date.new(2018,2,5), Date.new(2018,2,8))
#       @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4)) # before
#       res2 = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,6))
#       @manager.reserve_room(Date.new(2018,2,6), Date.new(2018,2,7)) # after
#       res_on_date = @manager.get_reservations_on_date(Date.new(2018,2,5))
#
#       res_on_date.must_equal [res1, res2]
#     end
#
#     it 'does not include reservations that end on the date' do
#       @manager.reserve_room(Date.new(2018,2,2), Date.new(2018,2,5))
#       @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
#     end
#
#     it "throws an ArgumentError for an invalid date" do
#       proc { @manager.get_reservations_on_date("foo") }.must_raise ArgumentError
#     end
#   end # end of 'Get Reservations On Date'
#
#   describe 'Get Reservation Cost' do
#     before do
#       @manager = Hotel::BookingsManager.new
#     end
#     it 'the cost of a the reservation' do
#       @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4))
#       @manager.get_reservation_cost(1).must_equal 200.0
#     end
#
#     it 'the cost of a the reservation' do
#       @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4))
#       @manager.get_reservation_cost(1).must_equal 200.0
#     end
#
#     it 'the cost of a the reservation' do
#       @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4))
#       proc { @manager.get_reservation_cost(2) }.must_raise ArgumentError
#       proc { @manager.get_reservation_cost("foo") }.must_raise ArgumentError
#     end
#   end # end of 'Get Reservation Cost'
#
#   describe 'Get Available Room' do
#
#     before do
#       @manager = Hotel::BookingsManager.new
#     end
#
#     it 'returns an empty list if no rooms are available' do
#       @manager.rooms.size.times do
#         @manager.reserve_room(Date.new(2018,2,1), Date.new(2018,2,8))
#       end
#       @manager.get_available_rooms(Date.new(2018,2,1), Date.new(2018,2,8)).must_equal []
#     end
#
#     it 'returns an list of rooms available' do
#       @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,8))
#       @manager.reserve_room(Date.new(2018,2,2), Date.new(2018,2,8))
#       @manager.reserve_room(Date.new(2018,2,1), Date.new(2018,2,8))
#
#       available_rooms = @manager.get_available_rooms(Date.new(2018,2,5), Date.new(2018,2,6))
#       available_rooms.must_be_kind_of Array
#       available_rooms.size.must_equal 17
#     end
#
#     it 'does not include unavailable rooms ' do
#       reservation = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,8))
#       reservation.room_number
#       available_rooms = @manager.get_available_rooms(Date.new(2018,2,5), Date.new(2018,2,6))
#       (available_rooms.any? { |room| room.number == available_rooms}).must_equal false
#     end
#
#     # it 'only includes reservations that overlap with date' do
#     #   res1 = @manager.reserve_room(Date.new(2018,2,5), Date.new(2018,2,8))
#     #   @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4)) # before
#     #   res2 = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,6))
#     #   @manager.reserve_room(Date.new(2018,2,6), Date.new(2018,2,7)) # after
#     #   res_on_date = @manager.get_available_rooms(Date.new(2018,2,5))
#     #
#     #   res_on_date.must_equal [res1, res2]
#     # end
#     #
#     # it 'does not include reservations that end on the date' do
#     #   @manager.reserve_room(Date.new(2018,2,2), Date.new(2018,2,5))
#     #   @manager.get_available_rooms(Date.new(2018,2,5)).must_equal []
#     # end
#
#     it "throws an ArgumentError for an invalid date" do
#       proc {
#         @manager.get_available_rooms("foo", Date.new(2018,2,5))
#       }.must_raise ArgumentError
#
#       proc {
#         @manager.get_available_rooms(Date.new(2018,2,5), "foo")
#       }.must_raise ArgumentError
#
#       proc {
#         @manager.get_available_rooms(Date.new(2018,2,5), Date.new(2018,2,4))
#       }.must_raise ArgumentError
#     end
#   end # end of 'Get Available Room'
#
#
#   # describe 'Get Available On Dates' do
#   #   it 'returns an empty list if no reservations on date range' do
#   #   #   @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
#   #   #   @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4)) # before
#   #   #   @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
#   #   end
#   #   #
#   #   # it 'returns an list of reservations on date' do
#   #   #   res1 = @manager.reserve_room(Date.new(2018,2,5), Date.new(2018,2,8))
#   #   #   res2 = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,6))
#   #   #   res_on_date = @manager.get_reservations_on_date(Date.new(2018,2,5))
#   #   #
#   #   #   res_on_date.must_equal [res1, res2]
#   #   # end
#   #   #
#   #   # it 'only includes reservations that overlap with date' do
#   #   #   res1 = @manager.reserve_room(Date.new(2018,2,5), Date.new(2018,2,8))
#   #   #   @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,4)) # before
#   #   #   res2 = @manager.reserve_room(Date.new(2018,2,3), Date.new(2018,2,6))
#   #   #   @manager.reserve_room(Date.new(2018,2,6), Date.new(2018,2,7)) # after
#   #   #   res_on_date = @manager.get_reservations_on_date(Date.new(2018,2,5))
#   #   #
#   #   #   res_on_date.must_equal [res1, res2]
#   #   # end
#   #   #
#   #   # it 'does not include reservations that end on the date' do
#   #   #   @manager.reserve_room(Date.new(2018,2,2), Date.new(2018,2,5))
#   #   #   @manager.get_reservations_on_date(Date.new(2018,2,5)).must_equal []
#   #   # end
#   #   #
#   #   # it "throws an ArgumentError for an invalid date" do
#   #   #   proc { @manager.get_reservations_on_date("foo") }.must_raise ArgumentError
#   #   # end
#   # end # end of 'Get Available On Dates'
#
# end # end of 'BookingsManager'
