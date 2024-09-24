class PatientsController < ApplicationController
    before_action :set_patient, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
  
    def index
      @patients = Patient.all
    end
  
    def show
    end
  
    def new
      @patient = Patient.new
    end
  
    def create
      @patient = Patient.new(patient_params)
      @patient.user = current_user  # Associate patient with logged-in user
      if @patient.save
        redirect_to @patient, notice: 'Patient was successfully created.'
      else
        render :new
      end
    end
  
    def edit
        @patient = Patient.find(params[:id])
    end

    def statistics
        @patients_per_day = Patient.group_by_day(:created_at).count
        Rails.logger.debug @patients_per_day.inspect
      end
      
      
      
  
    def update
        @patient = Patient.find(params[:id])
        if @patient.update(patient_params)
          redirect_to @patient, notice: 'Patient was successfully updated.'
        else
          render :edit
        end
      end
  
      def destroy
        @patient = Patient.find(params[:id])
        @patient.destroy
        redirect_to patients_path, notice: 'Patient was successfully deleted.'
      end
      
  
    def patient_statistics
      @patient_stats = Patient.group_by_day(:created_at).count
    end
  
    private
  
    def set_patient
      @patient = Patient.find(params[:id])
    end
  
    def patient_params
        params.require(:patient).permit(:name, :age, :gender)
      end

      before_action :authorize_receptionist, only: [:new, :create, :edit, :update, :destroy]

      private
      
      def authorize_receptionist
        redirect_to root_path, alert: 'You are not authorized to perform this action' unless current_user.role == 'receptionist'
      end

      before_action :authorize_doctor, only: [:statistics]

private

def authorize_doctor
  redirect_to root_path, alert: 'You are not authorized to view this page' unless current_user.role == 'doctor'
end

      
  end
  