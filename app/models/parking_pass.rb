class ParkingPass < ApplicationRecord
  belongs_to :guest

  def active?
    if expiration_date
      expiration_date && expiration_date >= Date.today
    else
      true
    end
  end
end
