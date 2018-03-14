# require_relative 'spec_helper'
#
# describe 'Block class' do
#
#   describe 'Initializer' do
#     before do
#       @initial_room_number = [1, 2, 3, 4]
#       @initial_check_in = Date.new(2018,2,3)
#       @initial_check_out = Date.new(2018,2,5)
#       @initial_rate = 200.0
#
#       @block_info = {
#         room: @initial_room_number,
#         check_in: @initial_check_in,
#         check_out: @initial_check_out,
#         # rate: @initial_rate
#       }
#       @reservation = Hotel::Reservation.new(@reservation_info)
#       @cost = 200.0 * 2
#     end
#
#     it 'is an instance of Reservation' do
#       @reservation.must_be_instance_of Hotel::Reservation
#     end
#
#     it 'has a room number' do
#       @reservation.must_respond_to :room
#       @reservation.room.must_be_kind_of Integer
#       @reservation.room.must_equal @initial_room_number
#     end
#
#     it 'has a check-in date' do
#       @reservation.must_respond_to :check_in
#       @reservation.check_in.must_be_kind_of Date
#       @reservation.check_in.must_equal @initial_check_in
#     end
#
#     it 'has a check-out date' do
#       @reservation.must_respond_to :check_out
#       @reservation.check_out.must_be_kind_of Date
#       @reservation.check_out.must_equal @initial_check_out
#     end
#
#
#     it 'has a cost' do
#       @reservation.must_respond_to :cost
#       @reservation.cost.must_be_kind_of Float
#       @reservation.cost.must_equal @cost
#     end
#
#     it 'throws an error is check-in is not a date' do
#       proc {
#         @reservation_info[:check_in] = 'I am not a check-in date.'
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#       proc {
#         @reservation_info[:check_in] = nil
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#     end
#
#     it 'throws an error is check-out is not a date' do
#       proc {
#         @reservation_info[:check_out] = 'I am not a check-out date.'
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#       proc {
#         @reservation_info[:check_out] = nil
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#     end
#
#     it 'throws an error if check-in is the same day as check-out' do
#       proc {
#         @reservation_info[:check_in] = Date.new(2018,2,5)
#         @reservation_info[:check_out] = Date.new(2018,2,5)
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#     end
#
#     it 'throws an error if check-in is after check-out' do
#       proc {
#         @reservation_info[:check_in] = Date.new(2018,2,5)
#         @reservation_info[:check_out] = Date.new(2018,2,4)
#         Hotel::Reservation.new(@reservation_info)
#       }.must_raise ArgumentError
#     end
#   end # end of Initializer
#
# end # end of Reservation
