module Mathtype
  class EpsFileParser < FileParser
    def initialize(path)
      super(path)
      extract_mtef_from_epscomment(@raw)
    end

    def extract_mtef_from_epscomment(comment)
      string64 = @raw.gsub /%|\r|\n/, ""
      string64 = string64.gsub /.*MathType!MTEF!1!1!\+-(.*![0-9A-F]{4}!).*/, '\\1'
      checksum = string64[-5 .. -2]
      string64 = string64[ 0 .. -7]
      @equation = decode string64
    end
  end
end
