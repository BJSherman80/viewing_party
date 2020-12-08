require 'rails_helper'

describe Party, type: :model do
  describe 'relationships' do
    it { should belong_to :movie }
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :movie_id }
    it { should validate_presence_of :party_duration }
  end
end
