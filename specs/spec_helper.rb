require 'date'
require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/reservation.rb'
require_relative '../lib/hotel_manager.rb'
require_relative '../lib/reservation_dates.rb'
require_relative '../lib/reservable.rb'
require_relative '../lib/block.rb'
require_relative '../lib/dates_range.rb'
