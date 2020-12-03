class Party < ApplicationRecord
  belongs_to :movie, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :date, presence: true
  validates :start_time, presence: true
  validates :movie_id, presence: true

  def host_status
    require "pry"; binding.pry
    if current_user.id == user.id
      "Hosting"
    else
      "Invited"
    end
  end
end
