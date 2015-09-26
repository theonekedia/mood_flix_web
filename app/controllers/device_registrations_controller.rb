class DeviceRegistrationsController < ApplicationController
  before_action :set_device_registration, only: [:show, :edit, :update, :destroy]

  # GET /device_registrations
  # GET /device_registrations.json
  def index
    @device_registrations = DeviceRegistration.all
  end

  # GET /device_registrations/1
  # GET /device_registrations/1.json
  def show
  end

  # GET /device_registrations/new
  def new
    @device_registration = DeviceRegistration.new
  end

  # GET /device_registrations/1/edit
  def edit
  end

  # POST /device_registrations
  # POST /device_registrations.json
  def create
    @device_registration = DeviceRegistration.new(device_registration_params)

    respond_to do |format|
      if @device_registration.save
        format.html { redirect_to @device_registration, notice: 'Device registration was successfully created.' }
        format.json { render :show, status: :created, location: @device_registration }
      else
        format.html { render :new }
        format.json { render json: @device_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_registrations/1
  # PATCH/PUT /device_registrations/1.json
  def update
    respond_to do |format|
      if @device_registration.update(device_registration_params)
        format.html { redirect_to @device_registration, notice: 'Device registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_registration }
      else
        format.html { render :edit }
        format.json { render json: @device_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_registrations/1
  # DELETE /device_registrations/1.json
  def destroy
    @device_registration.destroy
    respond_to do |format|
      format.html { redirect_to device_registrations_url, notice: 'Device registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_registration
      @device_registration = DeviceRegistration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_registration_params
      params.require(:device_registration).permit(:device_id, :email, :registration_key, :user_id, :platform)
    end
end
