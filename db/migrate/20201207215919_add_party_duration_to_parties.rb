class AddPartyDurationToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :party_duration, :integer
  end
end
