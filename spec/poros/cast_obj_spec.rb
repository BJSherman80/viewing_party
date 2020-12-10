require 'rails_helper'

describe CastObj do
  it 'exists' do
    attr = {
      name: 'Bruce Willis',
      character: 'Korben Dallas'
    }

    cast = CastObj.new(attr)

    expect(cast.name).to eq('Bruce Willis')
    expect(cast.character).to eq('Korben Dallas')
  end
end
