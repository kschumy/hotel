# require_relative 'spec_helper'
#
# describe 'Reservable module' do
#   TestDateRange = Struct.new(:check_in, :check_out)
#
#   describe 'Get reservations' do
#
#     before do
#       @default_check_in = Date.new(2018,2,5)
#       @default_check_out = Date.new(2018,2,9)
#       @default_dates = TestDateRange.new(check_in: @default_check_in,
#         check_out: @default_check_out)
#       @reservations = [@default_dates]
#     end
#
#     it 'must return a list' do
#       Reservable.must_respond_to :get_reservations
#       Reservable.get_reservations.must_be_kind_of Array
#     end
#
#     it 'must preserves the original list' do
#       Reservable.get_reservations.pop
#       Reservable.get_reservations.last.must_equal @default_dates
#     end
#   end
#
#   # describe 'get available rooms' do
#   #
#   #   before do
#   #     @reservations = []
#   #     @rooms = get_rooms
#   #     @reservations << Struct.new(room: @rooms.first, check_in: Date.new(2018,2,5),
#   #       check_out: Date.new(2018,2,9))
#   #     @reservations << Struct.new(room: @rooms.last, check_in: Date.new(2018,2,2),
#   #       check_out: Date.new(2018,2,8))
#   #   end
#   #
#   #   it 'must return a list' do
#   #     @reservations.must_respond_to :get_rooms
#   #     @reservations.must_be_kind_of Array
#   #   end
#   #
#   # end # end of 'Initializer'
# end
