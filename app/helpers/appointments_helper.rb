module AppointmentsHelper
  #for more readable date formats
  def date_for_display(date)
    fsdate = (date == nil) ? date : date.strftime('%b %d %Y %I:%M %p') 
  end
end