class Guest < ApplicationRecord
belongs_to :group
has_many :parking_passes
end
