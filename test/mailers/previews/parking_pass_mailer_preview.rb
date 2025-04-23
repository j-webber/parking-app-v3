# Preview all emails at http://localhost:3000/rails/mailers/parking_pass_mailer
class ParkingPassMailerPreview < ActionMailer::Preview
   # Preview this email at http://localhost:3000/rails/mailers/parking_pass_mailer/send_pass
   def send_pass
    ParkingPassMailer.with(parking_pass: Guest.find(980190963).parking_passes.last, guest: Guest.find(980190963)).send_pass
  end
end
