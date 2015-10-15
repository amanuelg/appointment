class AppointmentsController < ApplicationController
helper :appointments
before_action :set_appointment, only: [:show, :edit, :update, :destroy]

    def index 
        @appointments = Appointment.all
    end
    
    def show
    end
    
    def new
        @appointment = Appointment.new()
    end
    
    def create
        
        @appointment = Appointment.new(appointment_params)
        
        if @appointment.save
            flash[:success] = "Appointment Created Successfully"
            redirect_to @appointment
        else
            flash[:danger] = "Error Creating appointment"
            render 'new'
        end
    end
    
    def edit
        @appointment.start_time = @appointment.start_time.strftime("%m/%d/%Y %I:%M %p")
        @appointment.end_time = @appointment.end_time.strftime("%m/%d/%Y %I:%M %p")
        
    end
    
    def update
        
        if @appointment.update_attributes(appointment_params)
            flash[:success] = "Appointment Updated Successfully"
            redirect_to @appointment
        else
            
            @appointment.start_time = @appointment.start_time.strftime("%m/%d/%Y %I:%M %p")
            @appointment.end_time = @appointment.end_time.strftime("%m/%d/%Y %I:%M %p")
            flash[:notice] = "Error Creating Appointment"
            render 'edit'
        end
        
    end
    
    def destroy
        @appointment.destroy
        redirect_to appointments_path
    end
    
    
    private
    
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
        valid = params.require(:appointment).permit(:start_time, :end_time, :first_name, :last_name, :comment)
        date_format = "%m/%d/%Y %I:%M %p"
        valid[:start_time] = valid[:start_time] != "" ? DateTime.strptime(valid[:start_time], date_format) : valid[:start_time]
        valid[:end_time] = valid[:end_time] != "" ? DateTime.strptime(valid[:end_time], date_format) : valid[:end_time]
    return valid
    end
end