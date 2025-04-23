class ParkingPass < ApplicationRecord
  belongs_to :guest
  has_and_belongs_to_many :valid_days

  def active?
    if expiration_date
      expiration_date && expiration_date >= Date.today
    else
      true
    end
  end
end
