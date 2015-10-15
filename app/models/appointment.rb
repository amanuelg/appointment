
require 'csv'

class Appointment < ActiveRecord::Base
    
    #validate :start_should_be_future, :end_time_should_be_future
    validate :appointment_overlapping
    validate :start_shouldbe_less_than_ent_time
    
    #named scope for checking overlaping schedule 
    scope :overlaps, ->(appointment) do
        where "((start_time <= ?) and (end_time >= ?))", appointment.end_time, appointment.start_time
    end
    
    
    def start_should_be_future
        if self.start_time <= Time.now
            errors.add(:start_time, "should be in the future")
        end
    end
    
    def end_time_should_be_future
        if self.end_time <= Time.now
            errors.add(:end_time, "should be in the future")
        end
    end
    
    def start_shouldbe_less_than_ent_time
        if self.start_time >= self.end_time
            errors.add(:base, "Start time should be always less than end time")
        end
    end
    
    
    def appointment_overlapse
        overlaping = self.class.overlaps(self)
        if self.new_record?
            self.class.overlaps(self).count > 0
        else
            (overlaping - Array(self)).count > 0
        end
            
    end
        
    def appointment_overlapping
        if appointment_overlapse
            errors.add(:base,"appointment overlaps with other appointment")
        end
    end

end
