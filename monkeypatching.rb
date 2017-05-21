require "unicode"

class String
  def upcase
    return Unicode::upcase self
  end
end
