require_relative "file_parser/wmf.rb"
require_relative "file_parser/ole.rb"

module Mathtype
  module FileParser
    class FileParser
      attr_reader :raw
      attr_reader :equation
      def initialize(path)
        read_from_file(path)
      end

      def read_from_file(path)
        f = File.open(path, "rb")
        @raw = f.read
      end
    end
  end
end
