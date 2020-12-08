class Party < ApplicationRecord
  belongs_to :movie, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :date, presence: true
  validates :start_time, presence: true
  validates :movie_id, presence: true
  validates :party_duration, presence: true

  def host_status(user)
    if user.id == user_id
      "Hosting"
    else
      "Invited"
    end
  end
end
