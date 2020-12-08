class Guest < ApplicationRecord
  belongs_to :party
  belongs_to :guest, class_name: "User"
end
