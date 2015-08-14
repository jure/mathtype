# SIZE record (9):
# Consists of one of the following cases:

# if lsize < 0 (explicit point size):
# record type (9)
# 101
# -point size (16 bit integer)
# else if -128 < dsize < +128:
# record type (9)
# lsize (typesize)
# dsize + 128
# else: (large delta)
# record type (9)
# 100
# lsize (typesize)
# dsize (16 bit integer)
# Sizes in MathType are represented as a pair of values, lsize and dsize. Lsize
# stands for "logical size", dsize for "delta size". If it is negative, it is an
# explicit point size (in 32nds of a point) negated and dsize is ignored.
# Otherwise, lsize is a typesize value and dsize is a delta from that size:
# Simple typesizes, without a delta value, are written using the records
# described in the next section.

module Mathtype
  class RecordSize < BinData::Record
    endian :little
    int8 :lsize

    uint16 :point_size, onlyif: lambda { lsize == 101 }

    dsize_choice = lambda do
      if lsize == 100
        100
      elsif lsize != 100 && lsize != 101
        0
      end
    end

    choice :dsize, selection: dsize_choice do
      uint16 100
      uint16 0
    end
  end
end
