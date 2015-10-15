require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  def setup
    @appointment = Appointment.new(first_name: "john", last_name: "doe", start_time: Time.now.utc+3600, end_time: Time.now.utc+7200)
    assert @appointment.valid?
  end
  
  test "start time should be in the future" do
    @appointment.start_time = Time.now.utc-3600
    assert_not @appointment.valid?
  end
  
  test "end time should be in the future" do
    @appointment.end_time = Time.now.utc-7200
    assert_not @appointment.valid?
  end
  
  test "start time should be less than end time" do
    @appointment.start_time = Time.now.utc
    @appointment.end_time = Time.now.utc-8000
    assert_not @appointment.valid?
  end
  
  test "appointments shouldn't overlap" do
    @appointment1 = Appointment.new(first_name: "Amanuel", last_name: "Hailu", start_time: Time.now.utc+4000, end_time: Time.now.utc+8000)
    assert_not @appointment1.valid?
  end
  
  
  
end
