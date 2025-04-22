class ParkingPassesController < ApplicationController
  before_action :set_parking_pass, only: %i[ show edit update destroy ]
  before_action :set_guest, only: %i[ new create edit ]

  # GET /parking_passes or /parking_passes.json
  def index
    @parking_passes = ParkingPass.all
  end

  # GET /parking_passes/1 or /parking_passes/1.json
  def show
  end

  # GET /parking_passes/new
  def new
    @parking_pass = ParkingPass.new
  end

  # GET /parking_passes/1/edit
  def edit
  end

  # POST /parking_passes or /parking_passes.json
  def create
    @parking_pass = @guest.parking_passes.new(parking_pass_params)

      if @parking_pass.save
        qrcode = generate_parking_pass(@parking_pass)
        @parking_pass.update(qr_code: qrcode)
        # ParkingPassMailer.with(parking_pass: @parking_pass, guest: @guest).send_pass.deliver_later
        redirect_to guests_path, notice: "Parking pass was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /parking_passes/1 or /parking_passes/1.json
  def update
    respond_to do |format|
      if @parking_pass.update(parking_pass_params)
        format.html { redirect_to guests_path, notice: "Parking pass was successfully updated." }
        format.json { render :show, status: :ok, location: @parking_pass }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parking_pass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parking_passes/1 or /parking_passes/1.json
  def destroy
    @parking_pass.destroy!

    respond_to do |format|
      format.html { redirect_to guests_path, status: :see_other, notice: "Parking pass was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking_pass
      @parking_pass = ParkingPass.find(params.expect(:id))
    end

    def set_guest
      @guest = Guest.find(params.expect(:guest_id))
    end

    # Only allow a list of trusted parameters through.
    def parking_pass_params
      params.expect(parking_pass: [ :expiration_date, :qr_code, :valid_day, :guest_id ])
    end

    def generate_parking_pass(parking_pass)
      puts parking_pass
      RQRCode::QRCode.new(guest_parking_pass_url(parking_pass.guest_id, parking_pass.id)).as_svg
    end
end
