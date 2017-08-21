require "bindata"
require "ole/storage"
module Mathtype
  module FileParser
    class OleFileParser < FileParser
      def initialize(path)
        read_ole_from_file(path)
      end
      def read_from_file(path)
        ole = Ole::Storage.open(path, "rb+")
        @equation = ole.file.read("Equation Native")[28..-1]
        ole.close
      end
      if read_ole
        eq = read_ole(equation)
      else
        eq = equation
      end

    end
  end
end
