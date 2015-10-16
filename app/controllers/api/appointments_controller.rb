class Api::AppointmentsController < Api::ApiController

    #index now accepts parameters[optional] start_time and ent_time
    def index
        if params[:start_time] && params[:end_time]
            #catch if wrong datetime format is sent
            begin 
                startt = DateTime.strptime(params[:start_time], "%m/%d/%y %H:%M") 
                endt = DateTime.strptime(params[:end_time], "%m/%d/%y %H:%M") 
                render json: Appointment.where("start_time >= ? and end_time <= ?", startt,endt)
            rescue
                render status: 422, json: {message: "wrong parameters, start_time or end_time should be like in format of m/d/y H:M  eg: '10/18/15 09:00'!" }.to_json
            end
        else
            render json: Appointment.all
        end
    end
    
    def show
        appointment = Appointment.find(params[:id]) 
        render json: appointment
    end
    
    def create
       appointment = Appointment.new(appointment_params)
       
       if appointment.save
           render status: 200, json: {
               message: "Appointment Successfully created!",
               appointment: appointment
           }.to_json
           
       else
           render status: 422, json: {
               
               message: "Error Creating Appointment!",
               errors: appointment.errors
           }.to_json
       end
    
    end
    
    def destroy
        appointment = Appointment.find(params[:id])
        appointment.destroy
        render status: 200,json:{
            message: "Appointment Successfully Deleted"
        }.to_json
    end
    
    def update
        appointment = Appointment.find(params[:id])
        
        if appointment.update(appointment_params)
            render status: 200, json:{
                message: "Appointment Updated Successfully",
                appointment: appointment
            }.to_json
        else
            render status: 422, json:{
                
                message: "Appointment couldn't be updated",
                appointment: appointment.errors
            }.to_json
        end
    end
    
    private
    
    def appointment_params
        params.require(:appointment).permit(:start_time, :end_time, :first_name, :last_name, :comment)
    end
    
end

