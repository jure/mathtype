# PILE record (4):
# Consists of:
# record type (4)
# options
# [nudge] if mtefOPT_NUDGE is set
# [halign] horizontal alignment
# [valign] vertical alignment
# [[RULER record]] if mtefOPT_LP_RULER is set
# [object list] list of lines contained by the pile

# The row partition line type list consists of two-bit values for each possible
# partition line (one more than the number of rows), rounded out to the nearest
# byte. Each value determines the line style of the corresponding partition line
# (0 for none, 1 for solid, 2 for dashed, or 3 for dotted). Similarly for the
# column partition lines.

module Mathtype
  class RecordMatrix < BinData::Record
    int8 :options

    nudge :nudge, onlyif: lambda { options & OPTIONS["mtefOPT_NUDGE"] > 0 }

    int8 :valign
    int8 :h_just
    int8 :v_just
    int8 :rows
    int8 :cols

    array :row_parts, initial_length: lambda { rows + 1 } do
      bit nbits: 2
    end

    array :col_parts, initial_length: lambda { cols + 1 } do
      bit nbits: 2
    end

    array :object_list, read_until: lambda { element.record_type == 0 } do
      named_record
    end
  end
end
