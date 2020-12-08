class Guest < ApplicationRecord
  belongs_to :party
  belongs_to :friend, class_name: "User"
end
