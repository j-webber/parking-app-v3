class ValidDay < ApplicationRecord
  has_and_belongs_to_many :parking_passes
end
