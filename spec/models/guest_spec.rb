require 'test_helper'

describe Guest, type: :model do
  describe 'relationships' do
    it { should belong_to :party }
    it { should belong_to :friend }
  end
end
