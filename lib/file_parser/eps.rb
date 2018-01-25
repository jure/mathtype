module Mathtype
  class EpsFileParser < FileParser
    def initialize(path)
      super(path)
      extract_mtef_from_epscomment(@raw)
    end

    def extract_mtef_from_epscomment(comment)
      string64 = @raw.gsub /%|\r|\n/, ""
      string64 = string64.gsub /.*MathType!MTEF!1!1!\+-(.*![0-9A-F]{4}!).*/, '\\1'
      mtchecksum = string64[-5 .. -2]
      string64 = string64[ 0 .. -7]
      @equation = decode string64
      raise ArgumentError, "Checksums do not match, expected #{mtchecksum} but got #{checksum}" unless checksum == mtchecksum
    end
  end
end
