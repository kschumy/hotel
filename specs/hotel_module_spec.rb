require_relative 'spec_helper'

describe "Hotel Module" do

  describe "has_valid_date_or_error" do
    it "does not throw an error for a valid date" do
      Hotel.has_valid_date_or_error(Date.new(2018,2,5)).must_be_nil
    end

    it "throws an error for an invalid date" do
      proc { Hotel.has_valid_date_or_error("foo") }.must_raise ArgumentError
    end


  end
end
