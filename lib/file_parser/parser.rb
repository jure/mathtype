module Mathtype
  class FileParser
    attr_reader :raw
    attr_reader :equation
    def initialize(path)
      read_from_file(path)
    end

    def read_from_file(path)
      f = File.open(path, "rb")
      @raw = f.read
      f.close
    end

    A64 =
      {
      "a" => 0,
      "b" => 1,
      "c" => 2,
      "d" => 3,
      "e" => 4,
      "f" => 5,
      "g" => 6,
      "h" => 7,
      "i" => 8,
      "j" => 9,
      "k" => 10,
      "l" => 11,
      "m" => 12,
      "n" => 13,
      "o" => 14,
      "p" => 15,
      "q" => 16,
      "r" => 17,
      "s" => 18,
      "t" => 19,
      "u" => 20,
      "v" => 21,
      "w" => 22,
      "x" => 23,
      "y" => 24,
      "z" => 25,
      "A" => 26,
      "B" => 27,
      "C" => 28,
      "D" => 29,
      "E" => 30,
      "F" => 31,
      "G" => 32,
      "H" => 33,
      "I" => 34,
      "J" => 35,
      "K" => 36,
      "L" => 37,
      "M" => 38,
      "N" => 39,
      "O" => 40,
      "P" => 41,
      "Q" => 42,
      "R" => 43,
      "S" => 44,
      "T" => 45,
      "U" => 46,
      "V" => 47,
      "W" => 48,
      "X" => 49,
      "Y" => 50,
      "Z" => 51,
      "0" => 52,
      "1" => 53,
      "2" => 54,
      "3" => 55,
      "4" => 56,
      "5" => 57,
      "6" => 58,
      "7" => 59,
      "8" => 60,
      "9" => 61,
      "+" => 62,
      "-" => 63
    }

    def decode(string64)
      #decode from base64 mtef to binary mtef
      l = string64.length
      char = 0
      output = 0
      while char < l
        output += A64[string64[char].chr]
        output << 6
        print string64[char].chr
        if char % 4 == 3
          printf( ":%08d\n", output.to_s( 2))
          output = 0
        end
        char += 1
      end
      printf ":%08d\n", output.to_s(2)
      return output
    end

    def encode(equation)
      # TODO: encode binary mtef to base64 mtef + checksum
    end
  end
end

require_relative "wmf.rb"
require_relative "ole.rb"
require_relative "eps.rb"

