module Fish0
  module Concerns
    module Equalable
      def ==(other)
        other.class == self.class && other.attributes == attributes
      end
      alias eql? ==
    end
  end
end
