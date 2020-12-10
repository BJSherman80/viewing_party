require 'rails_helper'

describe ReviewObj do
  it 'exists' do
    attr = {
      author: 'Marv Albert',
      content: 'This movie was super cool'
    }

    review = ReviewObj.new(attr)

    expect(review.author).to eq('Marv Albert')
    expect(review.content).to eq('This movie was super cool')
  end
end
