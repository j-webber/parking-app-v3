class Guest < ApplicationRecord
belongs_to :group
has_many :parking_passes, dependent: :destroy
end
