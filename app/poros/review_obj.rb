class ReviewObj
  attr_reader :author, :content

  def initialize(attr)
    @author = attr[:author]
    @content = attr[:content]
  end
end
