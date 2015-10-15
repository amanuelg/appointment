require 'csv'

desc "Importing appointments as initial data"
task :import => [:environment] do

  file = "db/appointments.csv"
  
  CSV.foreach(file, :headers => true) do |row|
    appointment = Appointment.new({
      :start_time => DateTime.strptime(row[0], "%m/%d/%y %H:%M"),
      :end_time => DateTime.strptime(row[1], '%m/%d/%y %H:%M'),
      :first_name => row[2],
      :last_name => row[3]
      })
      
      if appointment.save
          puts("success.........................#{appointment.first_name} ...#{appointment.last_name}")
      else
          puts("error............#{appointment.errors.full_messages}")
      end
    
  end
end