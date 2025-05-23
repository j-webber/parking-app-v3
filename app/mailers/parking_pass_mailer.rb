class ParkingPassMailer < ApplicationMailer
  default from: "jgwebber1@gmail.com"

  def send_pass
    @parking_pass = params[:parking_pass]
    @guest = params[:guest]

    mail(to: @guest.email, subject: "Your parking pass")
  end
end
