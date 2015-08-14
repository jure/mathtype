# PILE record (4):

# Consists of:

# record type (4)
# options
# [nudge] if mtefOPT_NUDGE is set
# [halign] horizontal alignment
# [valign] vertical alignment
# [[RULER record]] if mtefOPT_LP_RULER is set
# [object list] list of lines contained by the pile

module Mathtype
  class RecordPile < BinData::Record
    int8 :options

    nudge :nudge, onlyif: lambda { options & OPTIONS["mtefOPT_NUDGE"] > 0 }

    int8 :halign
    int8 :valign

    record_ruler :ruler, onlyif: lambda { options & OPTIONS["mtefOPT_LP_RULER"] > 0 }

    array :object_list, read_until: lambda { element.record_type == 0 } do
      named_record
    end
  end
end
